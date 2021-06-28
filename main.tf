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
  profile = "default"
  region  = "us-east-1"
}

##########
# LOCALS #
##########
# locals {
#     env = "${var.env}"
#     subnet_id = "${var.subnet_id}"
#     instance_type = "${var.instance_type}"
#     instance_ami = "${var.instance_ami}"
#     instance_count = "${var.instance_count}"
#     instance_name = "${var.instance_name}"
#     key_name = "${var.key_name}"
#     pgclients_ingress_rules = ["${var.pgclients_ingress_rules}"]
# }

########
# DATA #
########
data "aws_subnet" "postgres_subnet" {
    id = "${var.subnet_id}"
}

data "aws_vpc" "main_vpc" {
    id = data.aws_subnet.postgres_subnet.vpc_id
}

##################
# SECURITY GROUP #
##################
resource "aws_security_group" "postgres-sg" {
  vpc_id      = data.aws_vpc.main_vpc.id
  name = "postgres-sg"
  description = "Security group for PostgreSQL"

  dynamic "ingress" {
      for_each = var.pgclients_ingress_rules
      content {
          from_port = 5432
          to_port = 5432
          protocol = "tcp"
          cidr_blocks = ingress.value.cidr_blocks
          description = ingress.value.description
      }
  }
  # The default egress rule
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

############
# INSTANCE #
############
module "postgres-ec2" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "${var.instance_name}"
  instance_count         = "${var.instance_count}"

  ami                    = "${var.instance_ami}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.key_name}"

  monitoring             = true
  vpc_security_group_ids = [aws_security_group.postgres-sg.id]
  subnet_id              = data.aws_subnet.postgres_subnet.id

  tags = {
    Terraform   = "true"
    Environment = "${var.env}"
  }
}