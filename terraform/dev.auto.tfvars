aws_profile = "tlap"
region = "us-east-1"
env = "dev"
instance_type = "t2.micro"
instance_ami = "ami-0b0af3577fe5e3532"
instance_count = 1
instance_name = "postgres-patroni"
instance_size = "10"
key_name = "tlap"
key_path = "../keys/pem"
pgclients_ingress_rules = [
    {
        port        = "5432"
        protocol    = "tcp"
        cidr_blocks = ["10.0.1.0/24"]
        description = "Ingress from client subnet"
    }, 
    # {
    #     port        = "-1"
    #     protocol    = "icmp"
    #     cidr_blocks = ["0.0.0.0/0"]
    #     description = "Ping from all"        
    # },
    {
        port        = "22"
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH from all"        
    }
]  
