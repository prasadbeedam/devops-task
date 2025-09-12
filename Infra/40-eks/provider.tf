terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.95.0"
    }
  }
  backend "s3" {
    bucket = "logo-server-terraform-remote-state"
    key    = "logo-server-dev-eks"
    region = "us-east-1"
    dynamodb_table = "logo-server-infra-locking"
  }
}

#provide authentication here
provider "aws" {
  region = "us-east-1"
}