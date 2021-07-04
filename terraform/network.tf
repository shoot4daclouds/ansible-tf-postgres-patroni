# The following template creates the following:
#   - 1 VPC
#   - 1 public subnet in us-east-1a
#   - 1 private subnet in us-east-1c
#   - 1 internet gateway associated with vpc
#   - 1 route table (associated to public subnet)
#     - internet reachability via internet gateway
#     - local traffic from within VPC
#   - 1 route table (associated to private subnet)
#     - local traffic from within VPC
#######
# VPC #
#######
resource "aws_vpc" "main_vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}
####################
# Internet Gateway #
####################
resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = var.igw_name
  }
}
##################
# public subnets #
##################
resource "aws_subnet" "subnet-public-1" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.pubsub_cidr_block
  map_public_ip_on_launch = true   // makes this a public subnet
  availability_zone = var.pubsub_az
  tags = {
    Name = var.pubsub_name
  }
}
##################################
# route table for public subnets #
##################################
resource "aws_route_table" "PublicRT" {    # Creating RT for Public Subnet
  vpc_id =  aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.main-igw.id
  }
 }
###############################################
# route table associations for public subnets #
###############################################
resource "aws_route_table_association" "PublicRTassociation-1" {
  subnet_id = aws_subnet.subnet-public-1.id
  route_table_id = aws_route_table.PublicRT.id
}
###################
# private subnets #
###################
resource "aws_subnet" "subnet-private-1" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.privsub_cidr_block
  availability_zone = var.privsub_az
  tags = {
      Name = var.privsub_name
  }
}
