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
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main_vpc"
  }
}
####################
# Internet Gateway #
####################
resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "main-igw"
  }
}
##################
# public subnets #
##################
resource "aws_subnet" "subnet-public-1" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true   // makes this a public
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnet-public-1"
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
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1c"
  tags = {
      Name = "subnet-private-1"
  }
}
