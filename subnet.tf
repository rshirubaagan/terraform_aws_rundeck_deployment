# subnet
resource "aws_subnet" "subnet-example" {
  vpc_id            = aws_vpc.example.id
  availability_zone = var.zone_a
  cidr_block        = "10.20.0.0/24"
  tags = {
    "Name" = "Rundeck Terraform Deployment Example Subnet"
  }
}

# association to route table
resource "aws_route_table_association" "route_table_assoc-example" {
  subnet_id      = aws_subnet.subnet-example.id
  route_table_id = aws_route_table.route_table-pub-example.id
}
