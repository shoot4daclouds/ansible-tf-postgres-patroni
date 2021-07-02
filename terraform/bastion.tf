##########################
# BASTION SECURITY GROUP #
##########################
resource "aws_security_group" "bastion-sg" {
  vpc_id      = aws_vpc.main_vpc.id
  name = "bastion-sg"
  description = "Security group for bastion host"

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "SSH from laptop"
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
    Name = "bastion-sg"
    Terraform   = "true"
    Environment = var.env
  }
}

####################
# BASTION INSTANCE #
####################
resource "aws_instance" "bastion" {

  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.subnet-public-1.id
  vpc_security_group_ids = [aws_security_group.bastion-sg.id]
  monitoring                  = true
  
  tags = {
    Name        = "bastion-host"
    Terraform   = "true"
    Environment = var.env
  }
}