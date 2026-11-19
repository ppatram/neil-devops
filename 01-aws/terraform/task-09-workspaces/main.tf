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

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "server" {
  ami = data.aws_ami.ubuntu.id
  instance_type = terraform.workspace == "dev" ? "t2.nano" : "t2.micro"

  tags = {
    Name = terraform.workspace == "prod" ? "prod_server" : "dev_server"
  }
}
