variable "vpc_cidr" {
    default = "100.10.0.0/16"
    type = string
    description = "providing vpc"
}

variable "instance_tenancy" {
    default = "default"
}

variable "vpc_tag" {
type=map(string)
default = {
  Location = "Bangalore"
}
}

variable "aws_subnet" {
    default = "100.10.0.0/24"
    type = string
    description = "providing subnet"
}

variable "aws_subnet_tags"{
    type=map(string)
    default= {
    Name = "Subnet-1"
  }
}

variable "ingress" {
    default = [80, 443, 22, 53] 
}