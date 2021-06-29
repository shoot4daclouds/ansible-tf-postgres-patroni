variable "aws_profile" {
  type        = string
  description = "AWS cli credential profile to use."
}
variable "region" {
  type        = string
  description = "AWS region to use."
}
variable "env" {
  type        = string
  description = "The environment name."
}
variable "subnet_id" {
  type        = string
  description = "The subnet id."
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
variable "instance_name" {
  type        = string
  description = "The name of the instance"
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