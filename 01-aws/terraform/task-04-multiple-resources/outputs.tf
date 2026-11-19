output "instance_ip" {
  description = "IP address of the EC2 instance"
  value = aws_instance.this_instance.public_ip
}
