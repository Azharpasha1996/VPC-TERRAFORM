variable "aws_region" {
    description = "AWS-region"
    type = string
    default = "ap-south-1"
  
}

variable "project_name" {
    description = "Name of the project"
    type = string
    default = "Dev-project"
  
}



variable "vpc_cidr" {
    description = "CIDR block for VPC"
    type = string
    default = "10.0.0.0/16"
  
}

variable "public_subnet_cidr" {
    description = "CIDR block for the public subnet"
    type = string
    default = "10.0.1.0/24"
  
}

variable "private_subnet_cidr" {
    description = "CIDR block for the private subnet"
    type = string
    default = "10.0.2.0/24"
  
}

variable "availability_zone" {
    description = "Availibility zone for the subnets"
    type = string
    default = "ap-south-1a"
  
}

