#####################################################################
# instance

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_key_pair" "my_ssh_key" {
  key_name = "my_ssh_key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "this_instance" {
  ami = data.aws_ssm_parameter.ami.value

  instance_type = "t3.micro"
  subnet_id = aws_subnet.my_subnet_1.id
  #associate_public_ip_address = true
  key_name = aws_key_pair.my_ssh_key.key_name
  vpc_security_group_ids = [ aws_security_group.my_security_group.id ]
}

resource "aws_eip" "this_elastic_ip" {
  instance = aws_instance.this_instance.id
  domain = "vpc"
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
