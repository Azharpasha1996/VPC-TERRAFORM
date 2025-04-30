variable "aws_region" {
    description = "Aws region"
    type = string
    default = "ap-south-1"
  
}

variable "ami_id" {
    description = "Ami ID for Ec2"
    type = string
  
}

variable "instance_type" {
    description = "Type of EC2 instance"
    type = string
    default = "t2.micro"
  
}

variable "key_name" {
    description = "Name of your AWS key pair"
    type = string

}