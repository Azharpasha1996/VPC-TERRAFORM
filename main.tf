provider "aws" {
    region = var.aws_region
  
}

resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
      Name = "${var.project_name}-vpc"
    }
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
      Name = "${var.project_name}-igw"
    }
  
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr
    map_public_ip_on_launch = true
    availability_zone = var.availability_zone

    tags = {
      Name ="${var.project_name}-pub-subnet"
    }
  
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr
    availability_zone = var.availability_zone

    tags = {
      Name = "${var.project_name}-pvt-subnet"
    }
  
}

resource "aws_eip" "nat_eip" {
    domain = vpc

  
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public.id

    tags = {
      Name = "${var.project_name}-nat-gateway"
    }

    depends_on = [ aws_internet_gateway.igw ]
  
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    
    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
      Name = "${var.project_name}-public-rt"
    }
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id
    
    route = {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_internet_gateway.nat.id
    }

    tags = {
      Name = "${var.project_name}-private-rt"
    }
}

# Associate public subnet with public route table

resource "aws_route_table_association" "pub-assoc" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
  
}

# Associate private subnet with private route table

resource "aws_route_table_association" "pvt-assoc" {
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.private.id
  
}