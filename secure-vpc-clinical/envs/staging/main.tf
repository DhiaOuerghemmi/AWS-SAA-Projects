provider "aws" {
  alias   = "this"
  region  = "us-east-1"
  profile = var.profile_staging
}

terraform {
  backend "s3" {
    bucket         = "tf-state-secure-clinical"
    key            = "staging/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    kms_key_id     = aws_kms_key.state.key_id
    dynamodb_table = "tf-lock-secure-clinical-staging"
  }
}

module "vpc" {
  source        = "../../modules/vpc"
  name          = "staging"
  cidr_block    = var.vpc_cidr
  azs           = var.azs
  public_cidrs  = var.public_cidrs
  private_cidrs = var.private_cidrs
  region        = "us-east-1"
}

// ... same module invocations as dev ...
