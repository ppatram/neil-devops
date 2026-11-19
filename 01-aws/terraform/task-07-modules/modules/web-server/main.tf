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

#####################################################################
# instance

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "this_instance" {
  count = var.num_instances
  ami = data.aws_ssm_parameter.ami.value

  instance_type = var.instance_type
  subnet_id = var.subnet_id
  #associate_public_ip_address = true
  key_name = var.key_name
  vpc_security_group_ids = [ var.security_group_id ]
}

resource "aws_eip" "this_elastic_ip" {
  count    = length(aws_instance.this_instance)
  instance = aws_instance.this_instance[count.index].id
  domain = "vpc"
}

resource "aws_route53_record" "my_route53_record" {
  count    = length(aws_instance.this_instance)
  zone_id = "Z09770641YMY3MPXX3Q2W"
  name    = "${var.subdomain_name}${count.index}.${var.application_name}.hakerie.fyi"
  type    = "A"
  ttl     = 300
  records = [aws_eip.this_elastic_ip[count.index].public_ip]
}
