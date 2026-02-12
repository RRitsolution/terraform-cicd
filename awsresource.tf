provider "aws" {
region = "ap-south-1"

alias = "mumbai-region"

}

resource "aws_instance" "ap-south-1_test_vm" {

  ami = "ami-019715e0d74f695be"
  provider = aws.mumbai-region
  instance_type = "t2.micro"

  tags = {
    Name = "test-vm"
  }


}


provider "aws" {
region = "us-east-1"

alias = "virginia-region"
}

resource "aws_instance" "us-east-1_test_vm" {

  ami = "ami-0b6c6ebed2801a5cb"
  provider = aws.virginia-region
  instance_type = "t2.micro"

  tags = {
    Name = "test-vm"
  }


}

