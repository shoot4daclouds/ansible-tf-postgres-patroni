##################
# AWS credential #
##################
variable "aws_profile" {
  type        = string
  description = "AWS cli credential profile to use."
}
variable "region" {
  type        = string
  description = "AWS region to use."
}
###############
# Environment #
###############
variable "env" {
  type        = string
  description = "The environment name."
}
#####################
# Network variables #
#####################
variable "vpc_name" {
  type        = string
  description = "Name of VPC."
}
variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block."
}
variable "igw_name" {
  type        = string
  description = "Name of IGW."
}
variable "pubsub_name" {
  type        = string
  description = "Name of public subnet."
}
variable "pubsub_cidr_block" {
  type        = string
  description = "Public subnet CIDR block."
}
variable "pubsub_az" {
  type        = string
  description = "Public subnet availability zone."
}
variable "privsub_name" {
  type        = string
  description = "Name of private subnet."
}
variable "privsub_cidr_block" {
  type        = string
  description = "Private subnet CIDR block."
}
variable "privsub_az" {
  type        = string
  description = "Private subnet availability zone."
}
#####################
# Bastion variables #
#####################
variable "bh_instance_name" {
  type        = string
  description = "The name of the bastion instance"
}
variable "bh_instance_type" {
  type        = string
  description = "The instance type for the bastion instance."
  default = "t2.micro"
}
variable "bh_instance_ami" {
  type        = string
  description = "The ami name for the bastion instance."
}
variable "bh_key" {
    type = string
    description = "Private Key for bastion instance."
}
variable "bh_key_path" {
    type = string
    description = "Local path to private key for bastion instance"
}
variable "bh_security_group_name" {
  type        = string
  description = "The name of the bastion security group."
}
variable "bh_ssh_ingress_cidr_block" {
  type        = string
  description = "The cidr block for incoming ssh to bastion instance."
}
########################
# Postgresql variables #
########################
variable "instance_name" {
  type        = string
  description = "The name of the instance."
}
variable "instance_type" {
  type        = string
  description = "The instance type."
  default = "t2.micro"
}
variable "instance_ami" {
  type        = string
  description = "The ami name."
}
variable "instance_count" {
  type        = number
  description = "The number of instances to create >= 3."
  default = 3
}
variable "instance_size" {
  type        = number
  description = "The size of volume."
}
variable "key_name" {
    type = string
    description = "Private Key for instance"
}
variable "key_path" {
    type = string
    description = "Local path to private key for instance"
}
variable "pgclients_ingress_rules" {
    type = list( object(
        {
            cidr_blocks = list(string)
            description = string
            port = string
            protocol = string
        }
    ))
}
