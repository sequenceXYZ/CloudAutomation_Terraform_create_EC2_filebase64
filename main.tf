provider "aws" {
  region = var.region
}

data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  # Filter for images that are eligible for the AWS Free Tier
  filter {
    name   = "usage-operation"
    values = ["RunInstances"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_vpc" "Agnija_vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "Agnija_subnet" {
  vpc_id                  = aws_vpc.Agnija_vpc.id
  cidr_block              = var.subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_name
  }
}

resource "aws_security_group" "Agnija_security_group" {
  vpc_id = aws_vpc.Agnija_vpc.id

  dynamic "ingress" {
    for_each = var.allowed_ports

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_name
  }
}

resource "aws_instance" "Agnija_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.Agnija_subnet.id
  vpc_security_group_ids = [aws_security_group.Agnija_security_group.id]


  user_data = filebase64(var.user_data)




  tags = {
    Name = var.instance_name
  }
}

output "instance_info" {
  description = "Information about the latest AWS Free Tier instance"
  value = {
    instance_id   = aws_instance.Agnija_instance.id
    public_ip     = aws_instance.Agnija_instance.public_ip
    private_ip    = aws_instance.Agnija_instance.private_ip
    instance_type = aws_instance.Agnija_instance.instance_type
    ami_id        = aws_instance.Agnija_instance.ami
  }
}

