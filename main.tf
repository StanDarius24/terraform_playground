terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Create a VPC
resource "aws_vpc" "demoVps" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true # Allow DNS lookups inside VPC
  enable_dns_hostnames = true # Give instances public DNS names if they have public IPs
}

# Subnet Public config
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.demoVps.id
  cidr_block = "10.0.1.0/24"

  map_public_ip_on_launch = true # Assign ip ipv4 at launch

  tags = {
    Name = "public"
  }
}

resource "aws_internet_gateway" "igw" { # internate gateway enables the connection to the internet
  vpc_id = aws_vpc.demoVps.id

  tags = {
    Name = "main"
  }
}

output "vpc_id" { value = aws_vpc.demoVps.id }
output "public_subnet_id" { value = aws_subnet.public.id }
output "private_subnet_id" { value = aws_subnet.private.id }


# Public route table → IGW
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.demoVps.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "public-rt" }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# NAT Gateway (must be in a public subnet + Elastic IP)
resource "aws_eip" "nat" {
  domain = "vpc"
  tags   = { Name = "nat-eip" }
}

resource "aws_nat_gateway" "nat" {
  subnet_id     = aws_subnet.public.id
  allocation_id = aws_eip.nat.id
  tags          = { Name = "demo-nat" }
}

# Subnet Private Config
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.demoVps.id
  cidr_block = "10.0.2.0/24"

  # availability_zone = "eu-central-1"

  tags = {
    Name = "private"
  }
}

# Private route table → NAT
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.demoVps.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = { Name = "private-rt" }
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "web_sg" {
  name   = "web-sg"
  vpc_id = aws_vpc.demoVps.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami                    = "ami-01cc34ab2709337aa"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
}

