locals {
tags =  merge(var.vpc_tag, {Name="IaC-demo-vpc-${terraform.workspace}"}, {Location = "Bangalore-${terraform.workspace}"})

}

locals {
  az_count=length(data.aws_availability_zones.available)
  az_available=data.aws_availability_zones.available
}