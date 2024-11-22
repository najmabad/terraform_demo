# Terraform code to create a VPC with two subnets in AWS


# Variables

# variable "subnet_cidr_block" {
#   description = "The CIDR block for the subnet"
#   default = "10.0.10.0/24"
# }

# variable "vpc_cidr_block" {
#   description = "The CIDR block of the VPC"
# }

variable "cidr_block" {
  description = "The CIDR block for the VPC and subnets"
  type = list(object({
    cidr_block = string
    name = string
  }
  ))
}

variable "environment" {
  description = "The environment of the resource"
}

# this is a global variable that we set with: export TF_VAR_avail_zone="eu-west-1a" for demo purposes
variable "avail_zone" {}

# Provider configurations
# We can avoid specifying configurations as we will use the default AWS config that we have set up locally with `aws configure`
provider "aws" {}


# Once you have a provider, you can create resources. 
# The convention it <provider>_<resource>
# You can see the names of the resources that you can create also in the official Terraform documentation
# After the official name, we can give the resource a name that is meaningful for us.

# Each resource block describes one or more infrastructure objects.

# VPC
resource "aws_vpc" "dev-vpc" {
  cidr_block = var.cidr_block[0].cidr_block # this is an IP address range that is assigned to the VPC
  tags = {
    Name: var.cidr_block[0].name
  }
}

# Subnet 1
resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.dev-vpc.id  # we can reference this ID even if the VPC is not created yet
  cidr_block = var.cidr_block[1].cidr_block # this is a subset of the IP range assigned to the VPC
  availability_zone = var.avail_zone # we can choose the first availability zone in this region (there are 3 in total)
  tags = {
    Name:  var.cidr_block[1].name
  }
}

# Subnet 2
# Now we will reference an existing VPC to create a new subnet in it
data "aws_vpc" "existing_vpc" {
  # filter criteria 
  default = true
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id = data.aws_vpc.existing_vpc.id
  cidr_block = "172.31.48.0/20" # this needs to be a subset of the IP range assigned to the VPC and
  # it also needs to be unique! I.e. two subnets cannot have the same IP range.
  availability_zone = var.avail_zone
  tags = {
    Name: "subnet-2-dev"
  }
}

output "dev-vpc-id" {
  value       = aws_vpc.dev-vpc.id
  description = "ID of the VPC"
}

output "dev-subnet-1-id" {
  value       = aws_subnet.dev-subnet-1.id
  description = "ID of the first subnet"
}

output "dev-subnet-2-id" {
  value       = aws_subnet.dev-subnet-2.id
  description = "ID of the second subnet"
}