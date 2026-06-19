data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_security_group" "web_sg" {
  name        = "GlobalMart-Web-SG"
  description = "Allow HTTP and restricted SSH"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Allow SSH from my IP only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_ip]
  }

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "GlobalMart-Web-SG"
    Project = "GlobalMart"
  }
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = "t3.micro"
  subnet_id                   = data.aws_subnets.default.ids[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name

  user_data = <<-EOF
    #!/bin/bash
    exec > /var/log/user-data.log 2>&1

    dnf update -y

    dnf install -y nginx nodejs npm unzip awscli

    systemctl start nginx
    systemctl enable nginx

    systemctl start amazon-ssm-agent
    systemctl enable amazon-ssm-agent

    mkdir -p /usr/share/nginx/html
  EOF

  tags = {
    Name    = "GlobalMart-WebServer"
    Project = "GlobalMart"
  }
}