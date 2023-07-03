# Environment
environment = "Production"

# VPC tfvars
vpc_cidr = "10.0.0.0/16"

public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

private_subnets = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]

azs = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]


# Instance tfvars
instance_type = "t2.nano"

key_name = "webappkey"

