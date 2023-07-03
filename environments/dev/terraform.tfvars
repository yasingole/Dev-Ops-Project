# Environment
environment = "Dev"

# VPC tfvars
vpc_cidr = "10.1.0.0/16"

public_subnets = ["10.1.1.0/24", "10.1.2.0/24"]

private_subnets = ["10.1.3.0/24", "10.1.4.0/24"]

azs = ["eu-west-2a", "eu-west-2b"]


# Instance tfvars
instance_type = "t2.micro"

key_name = "webappkey"
