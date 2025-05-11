provider "aws" {
  alias   = "this"
  region  = "us-east-1"
  profile = var.profile_dev
}

terraform {
  backend "s3" {
    bucket         = "tf-state-secure-clinical"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    kms_key_id     = aws_kms_key.state.key_id
    dynamodb_table = "tf-lock-secure-clinical-dev"
  }
}

module "vpc" {
  source        = "../../modules/vpc"
  name          = "dev"
  cidr_block    = var.vpc_cidr
  azs           = var.azs
  public_cidrs  = var.public_cidrs
  private_cidrs = var.private_cidrs
  region        = "us-east-1"
}

module "subnets" {
  source          = "../../modules/subnets"
  vpc_id          = module.vpc.vpc_id
  azs             = var.azs
  public_cidrs    = var.public_cidrs
  private_cidrs   = var.private_cidrs
}

module "nat" {
  source            = "../../modules/nat-gateway"
  public_subnet_ids = module.subnets.public_subnet_ids
}

module "flow_logs" {
  source = "../../modules/flow-logs"
  vpc_id = module.vpc.vpc_id
}