resource "aws_vpc" "app-vpc-viper" {

  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name    = "APP VPC"
    Project = "Viper"
  }
}

# We can define by use Count ? !
resource "aws_subnet" "app-viper-public-subnet-1" {
  vpc_id            = aws_vpc.app-vpc-viper.id
  cidr_block        = var.public_subnets_cidr[0]
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "app-viper-public-subnet-2" {
  vpc_id            = aws_vpc.app-vpc-viper.id
  cidr_block        = var.public_subnets_cidr[1]
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "app-viper-private-subnet" {
  vpc_id            = aws_vpc.app-vpc-viper.id
  cidr_block        = var.private_subnets_cidr[0]
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "Private Subnet"
  }
}

# CREATE IGW FOR INTERNET
resource "aws_internet_gateway" "app_viper_igw" {
  vpc_id = aws_vpc.app-vpc-viper.id
  tags = {
    Name = "Internet Gateway"
  }
}

# CREATE ROUTE TABLE
resource "aws_route_table" "app_viper_route_table" {
  vpc_id = aws_vpc.app-vpc-viper.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app_viper_igw.id
  }
  tags = {
    Name = "Public Subnet Route Table."
  }
}
# CREATE ASSOCIATION FOR PUBLIC SUBNET 
resource "aws_route_table_association" "app_viper-subnet_public-1" {
  subnet_id      = aws_subnet.app-viper-public-subnet-1.id
  route_table_id = aws_route_table.app_viper_route_table.id
}
resource "aws_route_table_association" "app_viper-subnet_public-2" {
  subnet_id      = aws_subnet.app-viper-public-subnet-2.id
  route_table_id = aws_route_table.app_viper_route_table.id
}



resource "aws_security_group" "allow_app" {
  name        = "allow-app"
  description = "Allow app inbound connections"
  vpc_id      = aws_vpc.app-vpc-viper.id
  ingress {
    from_port   = 80
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_app_sg"
  }
}
