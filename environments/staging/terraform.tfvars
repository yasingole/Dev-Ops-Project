# Environment
environment = "Staging"

# VPC tfvars
vpc_cidr = "192.168.0.0/16"

public_subnets = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]

private_subnets = ["192.168.11.0/24", "192.168.12.0/24", "192.168.13.0/24"]

azs = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]


# Instance tfvars
instance_type = "t2.nano"

key_name = "webappkey"

