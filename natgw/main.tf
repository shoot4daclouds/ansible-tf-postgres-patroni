#   - 1 NAT gateway in public subnet
#   - 1 elastic IP associated with NAT gateway
#   - 1 route table for private subnet
#     - internet reachability via NAT gateway
#   - 1 route table association

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = var.aws_profile
  region  = var.region
}

##################
# Nat elastic IP #
##################
resource "aws_eip" "natIP" {
  vpc   = true
}
###############
# Nat Gateway #
###############
resource "aws_nat_gateway" "NATgw" {
  allocation_id = aws_eip.natIP.id
  subnet_id = var.public_subnet_id
}
###################################
# route table for private subnets #
###################################
resource "aws_route_table" "PrivateRT" {    # Creating RT for Private Subnet
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"             # Traffic from Private Subnet reaches Internet via NAT Gateway
    nat_gateway_id = aws_nat_gateway.NATgw.id
  }
}
################################################
# route table associations for private subnets #
################################################
resource "aws_route_table_association" "PrivateRTassociation-1" {
  subnet_id = var.private_subnet_id
  route_table_id = aws_route_table.PrivateRT.id
}