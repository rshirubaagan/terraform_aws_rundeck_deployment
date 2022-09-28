# after the deployment Terraform must print the external EC2 instance public IP
output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "Rundeck Instance Public IP"
}