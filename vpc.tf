# the VPC
resource "aws_vpc" "example" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    "Name" = "Rundeck Terraform Deployment Example VPC"
  }
}

# internet gateway
resource "aws_internet_gateway" "igw-example" {
  vpc_id = aws_vpc.example.id
  tags = {
    "Name" = "Rundeck Terraform Deployment Example Internet Gateway"
  }
}

# route table
resource "aws_route_table" "route_table-pub-example" {
  vpc_id = aws_vpc.example.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-example.id
  }
  tags = {
    "Name" = "Rundeck Terraform Deployment Example Route Table"
  }
}
