# DevOps Project (AWS, Terraform, Git, Linux, CI/CD)

## Overview
This project is an automated infrastructure deployment and CI/CD project that leverages the power of AWS, Terraform, GitHub Actions, and Git to deploy an Nginx Web App in three different production environments.

This project focuses on:

- Creating custom reusable modules for the VPC and Web App to ensure consistency and reduce duplication using DRY principles.
- Incorporating best practices for security and network design to provision various AWS resources, including VPCs, subnets, instances, and ALBs.
- Using GitHub Actions workflows to enable automated updates to the infrastructure on pushes and pulls to the master branch.

## Directory Structure
The project is organized into the following directory structure:
![dir](Deenginers DevOps Project /images/dir.png)


The directory structure is clear and organized for the different components of the project:

- `modules`: Allows us to use reusable modules for the VPC and web application across different environments.
- `environments`: Allows us to set specific configuration variables required for each production environment. In our case, we have three environments: dev, staging, and production.
- `.github`: Will be used for our GitHub Actions workflows in the CI/CD stage.
- `.gitignore`: Will be used to hide files containing sensitive details, e.g., terraform.tfstate.

## Modules: VPC
To ensure consistency and make our code reusable across different production environments, we'll be using a variables.tf file.

`Variables.tf` Components:
- VPC CIDR
- Environment Variable (to allow selection of the production environment)
- Public and Private Subnets
- Availability Zones
```
variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = ""
}
variable "environment" {
  type    = string
  default = ""
}
variable "public_subnets" {
  type    = list(string)
  default = []
}
variable "private_subnets" {
  type    = list(string)
  default = []
}
variable "azs" {
  type    = list(string)
  default = []
}
```

To access the outputs of our module, we'll also be creating an outputs.tf file.

`Outputs.tf` Components:
- VPC ID
- Public and Private Subnet IDs
- NAT Gateway ID
- Public Route Table and Private Route Table ID
- Internet Gateway ID
```
output "vpc_id" {
  value = aws_vpc.webapp_vpc.id
}
output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}
output "private_subnet_ids" {
  value = aws_subnet.private_subnet[*].id
}
output "nat_gateway_ids" {
  value = aws_nat_gateway.webapp_ngw[*].id
}
output "public_route_table_id" {
  value = aws_route_table.public_rt.id
}
output "private_route_table_id" {
  value = aws_route_table.private_rt[*].id
}
output "internet_gateway_id" {
  value = aws_internet_gateway.webapp_igw.id
}
```

