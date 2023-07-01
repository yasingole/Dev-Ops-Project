variable "environment" {
  type = string
  default = ""
}

variable "public_subnets" {
  type = list
  default = []
}

variable "private_subnets" {
  type = list
  default = []
}

variable "private_subnet_ids" {
}

variable "public_subnet_ids" {
}

variable "vpc_id" {
  type = string
  default = ""
}

variable "instance_type" {
  type = string
  default = ""
}


variable "key_name" {
  type = string
  description = "Key pair name"
  default = ""
}