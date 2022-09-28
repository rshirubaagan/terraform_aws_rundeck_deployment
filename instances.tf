# key pair info to access the instance
resource "aws_key_pair" "example" {
  key_name   = "example"
  public_key = "xxx"
}

# the EC2 instance details
resource "aws_instance" "example" {
  ami                         = "ami-0bcf2639b551f6b31"
  subnet_id                   = aws_subnet.subnet-example.id
  instance_type               = "t3.large"
  key_name                    = "example"
  vpc_security_group_ids      = ["${aws_security_group.secgroup-example.id}"]
  private_ip                  = "10.20.0.100"

  # install and configure rundeck, then enables and launch the service
  # user: admin, password: eSWsAAUBRdhS
  user_data                   = <<-EOF
                #!/bin/bash
                sudo su
                yum -y update
                amazon-linux-extras install java-openjdk11
                curl https://raw.githubusercontent.com/rundeck/packaging/main/scripts/rpm-setup.sh 2> /dev/null | bash -s rundeck
                yum -y install rundeck
                rdeck_ip=$(curl http://checkip.amazonaws.com)
                sleep 2
                sed -i "s/localhost/$rdeck_ip/g" /etc/rundeck/rundeck-config.properties
                sed -i "s/localhost/$rdeck_ip/g" /etc/rundeck/framework.properties
                echo "admin:eSWsAAUBRdhS,user,admin,architect,deploy,build" > /etc/rundeck/realm.properties
                systemctl enable rundeckd.service
                systemctl start rundeckd.service
                EOF
  associate_public_ip_address = true

  # 10g disk instance 
  root_block_device {
    volume_size = 10
  }

  # EC2 instance tags
  tags = {
    Name        = "Rundeck EC2 Deployment"
    Description = "Rundeck Terraform Deployment EC2 instance"
  }
}
