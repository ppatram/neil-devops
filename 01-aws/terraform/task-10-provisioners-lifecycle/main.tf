terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_key_pair" "my_ssh_key" {
  key_name = "my_ssh_key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "this_instance" {
  ami = data.aws_ssm_parameter.ami.value
  instance_type = "t3.nano"
  key_name = "my_ssh_key"

  provisioner "local-exec" {
    command = "echo ${self.private_ip} > ip.txt"
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ec2-user"
      host = self.public_ip
      private_key = file("~/.ssh/id_ed25519")
    }
    inline = [ "echo 'this command is running on the remote machine' > remote.txt" ]
  }
}
