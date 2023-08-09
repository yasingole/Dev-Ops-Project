# VPC Module
# VPC
resource "aws_vpc" "webapp_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.environment} webapp vpc"
    Environment = var.environment
  }
}

# IGW
resource "aws_internet_gateway" "webapp_igw" {
  vpc_id = aws_vpc.webapp_vpc.id
  tags = {
    Name = "Webapp IGW"
    Environment = var.environment
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnets)
  vpc_id = aws_vpc.webapp_vpc.id
  cidr_block = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = "Public ${var.azs[count.index]}"
  }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnets)
  vpc_id = aws_vpc.webapp_vpc.id
  cidr_block = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = "Private ${var.azs[count.index]}"
  }
}

# Public route table and route
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.webapp_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.webapp_igw.id
  }
  tags = {
    Name = "${var.environment}-public-rt"
  }
}

# Elastic IP 
resource "aws_eip" "eip" {
  count = var.environment == "Production" ? length(aws_subnet.public_subnet) : 1
  tags = {
    Name = "${var.environment}-eip"
    Environment = var.environment
  }
}

# NAT GW
resource "aws_nat_gateway" "webapp_ngw" {
  count = var.environment == "Production" ? length(aws_subnet.public_subnet) : 1
  allocation_id = aws_eip.eip[count.index].id
  connectivity_type = "public"
  subnet_id = var.environment == "Production" ? aws_subnet.public_subnet[count.index].id : aws_subnet.public_subnet[0].id
  tags = {
    Name = "${var.environment}-nat-gateway"
    Environment = var.environment
  }
}

# Private route table and route
resource "aws_route_table" "private_rt" {
  count = length(aws_subnet.private_subnet)
  vpc_id = aws_vpc.webapp_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.environment == "Production" ? aws_nat_gateway.webapp_ngw[count.index].id : aws_nat_gateway.webapp_ngw[0].id
  }
  tags = {
    Name = "${var.environment}-${var.azs[count.index]}-private-route-table"
  }
}

# Public rt association
resource "aws_route_table_association" "public_rt_assoc" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

# Private rt association
resource "aws_route_table_association" "private_rt_assoc" {
  count          = length(aws_subnet.private_subnet)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt[count.index].id
}

