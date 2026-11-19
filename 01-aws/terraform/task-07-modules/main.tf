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

resource "aws_key_pair" "my_ssh_key" {
  key_name = "my_ssh_key"
  public_key = file("~/.ssh/id_ed25519.pub")
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


module "ec2_instances" {
  source = "./modules/web-server"
  instance_type = "t3.micro"
  security_group_id = aws_security_group.my_security_group.id
  vpc_id = aws_vpc.my_vpc.id
  subnet_id = aws_subnet.my_subnet_1.id
  key_name = aws_key_pair.my_ssh_key.key_name
  subdomain_name = terraform.workspace
  application_name = var.application_name
  num_instances = var.num_instances
}
#####################################################################
# internet gateway and route table

resource "aws_internet_gateway" "this_internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this_internet_gateway.id
  }
}

resource "aws_route_table_association" "my_association" {
  subnet_id = aws_subnet.my_subnet_1.id
  route_table_id = aws_route_table.my_route_table.id
}
