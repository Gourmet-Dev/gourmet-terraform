# Terraform
terraform {
    required_version = ">= 0.12"
}

# AWS 프로바이더
provider "aws" {
    region = var.gourmet_region
    access_key = var.gourmet_access_key
    secret_key = var.gourmet_secret_key
}