terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.95.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# VPC
resource "aws_vpc" "trend" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "trend-project-vpc"
  }
}

# Subnet
resource "aws_subnet" "trend_subnet" {
  vpc_id            = aws_vpc.trend.id
  cidr_block        = "172.16.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "trend-project-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "trend_igw" {
  vpc_id = aws_vpc.trend.id

  tags = {
    Name = "trend-project-IGW"
  }
}

# Route Table
resource "aws_route_table" "trend_public_rt" {
  vpc_id = aws_vpc.trend.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.trend_igw.id
  }

  tags = {
    Name = "trend-public-RT"
  }
}

# Route Table Association
resource "aws_route_table_association" "rt_association_public" {
  subnet_id      = aws_subnet.trend_subnet.id
  route_table_id = aws_route_table.trend_public_rt.id
}

# EC2 Instance
resource "aws_instance" "trend_ec2" {
  ami                         = "ami-02b8269d5e85954ef"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.trend_subnet.id
  associate_public_ip_address = true
  key_name                    = "VM1-APR12"

  tags = {
    Name = "trend-project"
  }
}

# IAM User
resource "aws_iam_user" "trend_user" {
  name = "john"
}

resource "aws_iam_user_login_profile" "user_login" {
  user                    = aws_iam_user.trend_user.name
  password_length         = 10
  password_reset_required = true
}
