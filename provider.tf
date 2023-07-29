terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.20.0"
    }

  }
  required_version = ">=0.1.5"
}
provider "aws" {
  region     = "us-east-1"
  access_key = var.PATH_TO_ACCESS_KEY
  secret_key = var.PATH_TO_SECRET_KEY
}

data "aws_availability_zones" "available" {
  state = "available"
}