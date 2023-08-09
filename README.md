# DevOps Project (AWS, Terraform, Git, Linux, CI/CD)

## Overview

This project is an automated infrastructure deployment and CI/CD project that leverages the power of AWS, Terraform, GitHub Actions, and Git to deploy a Nginx Web App in three different production environments.

This project focuses on:

- Creating custom reusable modules for the VPC and Web App to ensure consistency and reduce duplication using DRY principles.
- Incorporating best practices for security and network design to provision various AWS resources, including VPCs, subnets, instances, and ALBs.
- Using GitHub Actions workflows to enable automated updates to the infrastructure on pushes and pulls to the master branch.

## Directory Structure
The project is organized into the following directory structure:

`DevOps Project/`

`┣ modules/`

      ┗ vpc/

      ┗ webapp/

`┣ environments/`

      ┗ dev/

      ┗ prod/

      ┗ staging/

`┣ .github/`

      ┗ workflows/

`┗ .gitignore`




The directory structure is clear and organized for the different components of the project:

- `modules`: Allows us to use reusable modules for the VPC and web application across different environments.
- `environments`: Allows us to set specific configuration variables required for each production environment. In our case, we have three environments: dev, staging, and production.
- `.github`: Will be used for our GitHub Actions workflows in the CI/CD stage
- `.gitignore`: Will be used to hide files containing sensitivw details e.g terraform.tfstate

## Modules:
## `VPC`:
To ensure consistencey and make our code reusable across our differnt production environments, we'll be using `variables.tf` file.

`variables.tf` Components:
- VPC CIDR
```
variable "vpc_cidr" {
  description = "VPC CIDR"
  type = string
  default = ""
}
```
- Environment
  ```
  variable "environment" {
  type = string
  default = ""
}
```


