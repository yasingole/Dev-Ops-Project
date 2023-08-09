
# DevOps Project (AWS, Terraform, Git, Linux, CICD)

## Overview
This project is an automated infrastructure deployment and CI/CD project that leverages the power of AWS, Terraform, GitHub Actions, and Git to deploy an Nginx Web App in three different production environments.

## This project focuses on:
- Creating custom reusable modules for the VPC and Web App to ensure consistency and reduce duplication using DRY principles
- Incorporating best practices for security and network design to provision various AWS resources, including VPCs, subnets, instances, and ALBs
- Using GitHub Actions workflows to enable automated updates to the infrastructure on pushes and pulls to the master branch



Deenginers DevOps Project/

┣ modules/
┃ ┣ vpc/
┃ ┗ webapp/
┣ environments/
┃ ┣ dev/
┃ ┣ prod/
┃ ┗ staging/
┣ .github/
┃ ┗ workflows/
┗ .gitignore

