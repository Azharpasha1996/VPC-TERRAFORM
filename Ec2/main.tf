provider "aws" {
    region = var.aws_region
  
}

# Create a Security Group

resource "aws_security_group" "web_sg" {
    name = "web_sg"
    description = "Allow SSH and HTTP"
    vpc_id = data.aws_vpc.default.id

    ingress  {
        description = "Allow SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Allow HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "Allow all outbound"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "web_sg"
    }
  
}

# Get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Get all subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}



# Create an Ec2 Instance

resource "aws_instance" "web_server" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = data.aws_subnets.default.ids[0]
    vpc_security_group_ids = [aws_security_group.web_sg.id]
    key_name = var.key_name

    tags = {
      Name = "Terraform-Ec2"
    }
}
