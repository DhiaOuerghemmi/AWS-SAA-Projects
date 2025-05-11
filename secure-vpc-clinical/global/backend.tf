
terraform {
  backend "s3" {
    bucket         = "tf-state-secure-clinical"    # TO DO: replace with your state bucket name
    key            = "${terraform.workspace}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    kms_key_id     = aws_kms_key.state.key_id      # ensure aws_kms_key.state is defined in this module
    dynamodb_table = "tf-lock-secure-clinical"     # TO DO: replace with your lock table name
  }
}

resource "aws_kms_key" "state" {
  description = "KMS key for Terraform state encryption"
  policy      = data.aws_iam_policy_document.state.json
}

data "aws_iam_policy_document" "state" {
  statement {
    sid       = "Enable IAM User Permissions"
    effect    = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
}

data "aws_caller_identity" "current" {}
