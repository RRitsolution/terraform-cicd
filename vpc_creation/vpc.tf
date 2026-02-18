resource "aws_vpc" "nirmal_vpc" {
  cidr_block = var.cidr
  tags = {
    Name = "nirmal_vpc"

  }
}


resource "aws_subnet" "nirmal_subnet1" {
  vpc_id                  = aws_vpc.nirmal_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {

    Name = "nirmal_subnet1"
  }
}

resource "aws_subnet" "nirmal_subnet2" {

  vpc_id = aws_vpc.nirmal_vpc.id

  cidr_block = "10.0.1.0/24"

  availability_zone = "us-east-1b"

  map_public_ip_on_launch = true

  tags = {

    Name = "nirmal_subnet2"
  }
}


resource "aws_internet_gateway" "nirmal_igw" {

  vpc_id = aws_vpc.nirmal_vpc.id
  tags = {

    Name = "nirmal_igw"
  }
}



resource "aws_route_table" "nirmal_route_table" {

  vpc_id = aws_vpc.nirmal_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nirmal_igw.id
  }
  tags = {

    Name = "nirmal_route_table"
  }
}


resource "aws_route_table_association" "nirmal_route_table_association1" {
  subnet_id      = aws_subnet.nirmal_subnet1.id
  route_table_id = aws_route_table.nirmal_route_table.id

}

resource "aws_route_table_association" "nirmal_route_table_association2" {
  subnet_id      = aws_subnet.nirmal_subnet2.id
  route_table_id = aws_route_table.nirmal_route_table.id

}

resource "aws_security_group" "nirmal_sg" {

  name        = "nirmal_sg"
  description = "security group for nirmal_vpc"
  vpc_id      = aws_vpc.nirmal_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH access from anywhere"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP access from anywhere"
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }


  tags = {
    Name = "nirmal_sg"
  }


}


