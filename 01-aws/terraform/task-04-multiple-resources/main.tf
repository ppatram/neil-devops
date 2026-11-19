terraform {
  required_providers {
    aws={
      source="hashicorp/aws"
    }
  }
}

provider "aws" {
  region="us-east-1"
}

#####################################################################
# Resources
#####################################################################
# vpc

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

#####################################################################
# subnet

resource "aws_subnet" "my_subnet_1" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.0.0/24"
}

resource "aws_subnet" "my_subnet_2" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.4.0/24"
}

resource "aws_subnet" "my_subnet_3" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.8.0/24"
}

#####################################################################
# security group and ingress/egress rules

resource "aws_security_group" "my_security_group" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "my_ssh_ingress_rule" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port = 22
  to_port = 22
}

resource "aws_vpc_security_group_egress_rule" "my_ssh_egress_rule" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port = 0
  to_port = 65535
}

