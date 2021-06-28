env = "dev"
subnet_id = "subnet-c2d0cd8f"
instance_type = "t2.micro"
instance_ami = "ami-0b0af3577fe5e3532"
instance_count = 3
instance_name = "postgres-patroni"
key_name = "tlap"
pgclients_ingress_rules = [
    {
        cidr_blocks = ["0.0.0.0/0"]
        description = "Ingress from webapp subnet"
    }
]  
