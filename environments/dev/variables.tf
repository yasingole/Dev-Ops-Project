# Environment
variable "environment" {
  type = string
  description = "When set to dev/staging: Only one nat gateway and eip will be created. However, when set to production: One nat gateway and eip for every public subnet"
  default = ""
}

# VPC Vars
variable "vpc_cidr" {
  description = "VPC CIDR"
  type = string
  default = ""
}
variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "azs" {
  type = list(string)
  default = []
}


# Webapp Vars
variable "key_name" {
  type = string
  default = "webappkey"
}

variable "instance_type" {
  type = string
  default = ""
}


# Generic vars
# Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = ""
}

# Backend Config
variable "bucket_name" {
  type = string
  default = ""
}
variable "dynamodb_name" {
  type = string
  default = "dev"
}

