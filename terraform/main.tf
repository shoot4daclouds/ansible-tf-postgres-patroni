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

########
# DATA #
########
data "aws_subnet" "postgres_subnet" {
    id = var.subnet_id
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
      from_port = ingress.value.port
      to_port = ingress.value.port
      protocol = ingress.value.protocol
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

  tags = {
    Name = "postgres-sg"
    Terraform   = "true"
    Environment = var.env
  }
}

############
# INSTANCE #
############
resource "aws_instance" "postgres-ec2" {

  count         = var.instance_count
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = data.aws_subnet.postgres_subnet.id
  vpc_security_group_ids = [aws_security_group.postgres-sg.id]
  associate_public_ip_address = true
  monitoring                  = true

  root_block_device {
      volume_type = "gp2"
      volume_size = var.instance_size
  }
  
  tags = {
    Name        = "${var.instance_name}-${count.index}"
    Terraform   = "true"
    Environment = var.env
  }

  provisioner "remote-exec" {
    inline = ["echo 'Waiting for server to be initialized...'"]

    connection {
      type        = "ssh"
      agent       = false
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file(var.key_path)
    }
  }
}