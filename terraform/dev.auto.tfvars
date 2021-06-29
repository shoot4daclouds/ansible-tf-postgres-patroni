aws_profile = "tlap"
region = "us-east-1"
env = "dev"
subnet_id = "subnet-c2d0cd8f"
instance_type = "t2.micro"
instance_ami = "ami-0b0af3577fe5e3532"
instance_count = 3
instance_name = "postgres-patroni"
instance_size = "20"
key_name = "tlap"
key_path = "../keys/pem"
pgclients_ingress_rules = [
    {
        port        = "5432"
        protocol    = "tcp"
        cidr_blocks = ["172.31.0.0/16"]
        description = "Ingress from client subnet"
    }, 
    {
        port        = "22"
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH from all"        
    }
]  
