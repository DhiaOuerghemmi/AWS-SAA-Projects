// environments/prod/main.tf
provider "aws" {
  alias   = "this"
  region  = "us-east-1"
  profile = var.profile_prod
  assume_role {
    role_arn = var.prod_role_arn
  }
}

terraform {
  backend "s3" {
    bucket         = "tf-state-secure-clinical"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    kms_key_id     = aws_kms_key.state.key_id
    dynamodb_table = "tf-lock-secure-clinical-prod"
  }
}

module "vpc" {
  source        = "../../modules/vpc"
  name          = "prod"
  cidr_block    = var.vpc_cidr
  azs           = var.azs
  public_cidrs  = var.public_cidrs
  private_cidrs = var.private_cidrs
  region        = "us-east-1"
}

// ... same module invocations as dev ...
