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

data "aws_ami" "most_recent_al2023_ami" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "free-tier-eligible"
    values = [true]
  }

  filter {
    name = "name"
    values = ["al2023-ami-2023*"]
  }
}

data "aws_availability_zones" "my_az" {
}

data "aws_caller_identity" "me" {
}

data "aws_region" "my_region" {
}

data "aws_vpc" "my_vpc" {
  default = true
}

resource "aws_instance" "my_instance" {
  ami = data.aws_ami.most_recent_al2023_ami.id
  instance_type = "t3.micro"
  availability_zone = data.aws_availability_zones.my_az.names[0]
}

output "az" {
  description = "the availability zone"
  value = data.aws_availability_zones.my_az
}

output "acct-id" {
  description = "the account id"
  value = data.aws_caller_identity.me.account_id
}

output "region" {
  description = "my region"
  value = data.aws_region.my_region.id
}

output "ami-id" {
  description = "ami id chosen for the instance"
  value = data.aws_ami.most_recent_al2023_ami.id
}
