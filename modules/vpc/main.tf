# VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name        = "${var.project_name}-vpc"
    Engineer    = var.engineer
    ProjectCode = var.project_code
  }
}

# Public Subnets
resource "aws_subnet" "publicsubnet" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-publicsubnet${count.index+1}"
    Engineer    = var.engineer
    ProjectCode = var.project_code
  }
}

# Private Subnets
resource "aws_subnet" "privatesubnet" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "${var.project_name}-privatesubnet${count.index+1}"
    Engineer    = var.engineer
    ProjectCode = var.project_code
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.project_name}-igw"
    Engineer    = var.engineer
    ProjectCode = var.project_code
  }
}

# Public RTs routed to IGW
resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public-rt.id
  destination_cidr_block = var.int_cidr
  gateway_id             = aws_internet_gateway.igw.id
}

# Public Route Table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.project_name}-public-rt"
    Engineer    = var.engineer
    ProjectCode = var.project_code
  }
}

# Private Route Table
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.project_name}-private-rt"
    Engineer    = var.engineer
    ProjectCode = var.project_code
  }
}

# Public Subnet Associations
resource "aws_route_table_association" "public-rtassoc" {
  count          = length(aws_subnet.publicsubnet)
  subnet_id      = aws_subnet.publicsubnet[count.index].id
  route_table_id = aws_route_table.public-rt.id
}

# Private Subnet Associations
resource "aws_route_table_association" "private-rtassoc" {
  count          = length(aws_subnet.privatesubnet)
  subnet_id      = aws_subnet.privatesubnet[count.index].id
  route_table_id = aws_route_table.private-rt.id
}