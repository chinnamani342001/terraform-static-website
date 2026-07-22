#########################################
# Latest Ubuntu AMI
#########################################

data "aws_ami" "ubuntu" {

  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

#########################################
# Security Group
#########################################

resource "aws_security_group" "web_sg" {

  name = "terraform-web-sg"

  ingress {
    description = "SSH"

    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    description = "HTTP"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-SG"
  }

}

#########################################
# EC2 Instance
#########################################

resource "aws_instance" "webserver" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  key_name = var.key_name

  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]

  user_data = <<-EOF
#!/bin/bash

apt update -y

apt install apache2 unzip wget -y

systemctl enable apache2

systemctl start apache2

cd /var/www/html

rm -rf *

wget https://github.com/startbootstrap/startbootstrap-freelancer/archive/refs/heads/master.zip

unzip master.zip

cp -r startbootstrap-freelancer-master/* .

rm -rf master.zip startbootstrap-freelancer-master

systemctl restart apache2

EOF

  tags = {
    Name = "${var.project_name}-EC2"
  }

}
