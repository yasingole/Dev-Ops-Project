# VPC Vars
# VPC CIDR
variable "vpc_cidr" {
  description = "VPC CIDR"
  type = string
  default = ""
}

# Environment
variable "environment" {
  type = string
  default = ""
}

variable "public_subnets" {
  type = list(string)
  default = []
}

variable "private_subnets" {
  type = list(string)
  default = []
}

variable "azs" {
  type = list(string)
  default = []
}
