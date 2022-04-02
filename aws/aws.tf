# Terraform
terraform {
    required_version = ">= 0.12"
    backend "s3" {
        bucket = "gourmet-infrabase"
        key = "gourmet/terraform.tfstate"
        region = "ap-northeast-2"
        encrypt = true
        dynamodb_table = "InfrabaseLock"
        acl = "bucket-owner-full-control"
        profile = "default"
    }
}

# AWS 프로바이더
provider "aws" {
    region = var.gourmet_region
    profile = "default"
}