##################
# AWS credential #
##################
aws_profile = "tlap"
region = "us-east-1"
###############
# Environment #
###############
env = "dev"
#####################
# Network variables #
#####################
vpc_name = "main-vpc"
vpc_cidr_block = "10.0.0.0/16"
igw_name = "main-igw"
pubsub_name = "subnet-public-1"
pubsub_cidr_block = "10.0.1.0/24"
pubsub_az = "us-east-1a"            // Availability zone must exist within region var
privsub_name = "subnet-private-1"
privsub_cidr_block = "10.0.2.0/24"
privsub_az = "us-east-1c"           // Availability zone must exist within region var
#####################
# Bastion variables #
#####################
bh_instance_name = "bastion-host"
bh_instance_type = "t2.micro"
bh_instance_ami = "ami-0b0af3577fe5e3532"
bh_key = "tlap"
bh_key_path = "../keys/pem"
bh_security_group_name = "bastion-sg"
bh_ssh_ingress_cidr_block = "0.0.0.0/0"
########################
# Postgresql variables #
########################
instance_name = "postgres-patroni"
instance_type = "t2.micro"
instance_ami = "ami-0b0af3577fe5e3532"
instance_count = 1
instance_size = "10"
key_name = "tlap"
key_path = "../keys/pem"
pgclients_ingress_rules = [
    {
        port        = "5432"
        protocol    = "tcp"
        cidr_blocks = ["10.0.1.0/24"]
        description = "Ingress from client subnet."
    }, 
    {
        port        = "22"
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH from all."        
    }
]  
