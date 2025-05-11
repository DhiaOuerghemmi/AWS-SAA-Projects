terraform {
  required_version = ">= 1.5, < 2.0"      # verrouille la version de Terraform
}

provider "aws" {
  alias   = "dev"
  region  = "us-east-1"                   
  profile = var.profile_dev               
}

provider "aws" {
  alias   = "prod"
  region  = "us-east-1"                   
  profile = var.profile_prod              
}
provider "aws" {
  alias   = "staging"
  region  = "us-east-1"                   
  profile = var.profile_staging          
}
