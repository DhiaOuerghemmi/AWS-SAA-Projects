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
