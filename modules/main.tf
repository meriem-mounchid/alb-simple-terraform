terraform {
  required_version = "~> 1.3.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.70.0"
    }
  }
}
provider "aws" {
  region     = "eu-west-1"
}

resource "aws_instance" "my_web_server" {
  ami       = var.ami
  key_name  = "certif"
  instance_type = var.instance_type
  subnet_id     = aws_subnet.my_public_subnet.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  user_data = templatefile("${path.module}/../templates/instance_init.tpl",{
    lb_name = aws_lb.alb.dns_name
  })
  tags = {
    Name = "my_web_server"
  }
}

resource "aws_instance" "my_web_server2" {
  ami       = var.ami
  key_name  = "certif"
  instance_type = var.instance_type
  subnet_id     = aws_subnet.my_public_subnet2.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  user_data = templatefile("${path.module}/../templates/instance_init.tpl",{
    lb_name = aws_lb.alb.dns_name
  })
  tags = {
    Name = "my_web_server2"
  }
}
