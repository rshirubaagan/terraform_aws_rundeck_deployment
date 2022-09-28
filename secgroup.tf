# AWS Security Group
resource "aws_security_group" "secgroup-example" {
  depends_on  = [aws_vpc.example]
  name        = "secgroup-example"
  description = "Security Group for Rundeck Terraform Deployment Example"
  vpc_id      = aws_vpc.example.id
  tags = {
    Name = "Rundeck Terraform Deployment Example Security Group"
  }
}

# Rundeck (port 4440 by default)
resource "aws_security_group_rule" "rundeck" {
  type              = "ingress"
  description       = "rundeck"
  from_port         = 4440
  to_port           = 4440
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.secgroup-example.id
}

# SSH service (port 22)
resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  description       = "ssh"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.secgroup-example.id
}

# outcoming rule to "all"
resource "aws_security_group_rule" "all" {
  type              = "egress"
  description       = "all"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.secgroup-example.id
}
