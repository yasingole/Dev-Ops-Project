# VPC Module
module "vpc" {
  source = "../../modules/vpc"
  
  environment = var.environment
  vpc_cidr = var.vpc_cidr 
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  azs = var.azs
}

# Instance and ALB Module
module "webapp" {
  source = "../../modules/webapp"

  vpc_id = module.vpc.vpc_id
  environment = var.environment
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  instance_type = var.instance_type
  key_name = var.key_name
  
}

