resource "aws_vpc" "my_vpc" {
   cidr_block = "10.0.0.0/16"
   tags = {
       Name = "my_vpc"
   }
}

resource "aws_subnet" "my_public_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"
  tags = {
      Name = "my_public_subnet"
  }
}

resource "aws_subnet" "my_public_subnet2" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1c"
  tags = {
      Name = "my_public_subnet2"
  }
}

resource "aws_security_group" "my_security_group" {
  name_prefix = "my_security_group"
  description = "Testing my_security_group"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "igw"{
  vpc_id = aws_vpc.my_vpc.id
  tags ={
    Name = "igw"
  }
}

resource "aws_default_route_table" "public_rt" {
  default_route_table_id = aws_vpc.my_vpc.default_route_table_id
  tags = {
    Name = "public_rt"
  }
}

resource "aws_route" "public_route_gateway" {
  route_table_id = aws_default_route_table.public_rt.id

  depends_on = [
    aws_default_route_table.public_rt,
  ]

  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "rt_associate_public" {
  route_table_id = aws_default_route_table.public_rt.id
  subnet_id      = aws_subnet.my_public_subnet.id
}

resource "aws_route_table_association" "rt_associate_public2" {
  route_table_id = aws_default_route_table.public_rt.id
  subnet_id      = aws_subnet.my_public_subnet2.id
}