variable "aws_profile" {
  type        = string
  description = "AWS cli credential profile to use."
}
variable "region" {
  type        = string
  description = "AWS region to use."
}
variable "vpc_id" {
  type        = string
  description = "VPC ID for resources."
}
variable "public_subnet_id" {
  type        = string
  description = "Public subnet ID for NATgw."
}
variable "private_subnet_id" {
  type        = string
  description = "Private subnet Id."
}