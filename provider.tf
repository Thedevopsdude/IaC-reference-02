provider "aws" {
  region  = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-files-1"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.instance_tenancy
  tags = local.tags
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "my-ig-${terraform.workspace}"
  }
}

resource "aws_subnet" "main" {
  count=local.az_count
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr, 4, count.index)
  tags = local.tags
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "internet-gateway-public-route"
  }
}


resource "aws_route_table_association" "a" {
  count          = length(aws_subnet.main.*.id)
  subnet_id      = aws_subnet.main.*.id[count.index]
  route_table_id = aws_route_table.public.id
}