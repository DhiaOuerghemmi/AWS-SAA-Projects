#!/usr/bin/env bash
set -euo pipefail

echo "Initializing Terraform backend..."
terraform init \
  -backend-config="bucket=tf-state-secure-clinical" \
  -backend-config="key=${TF_WORKSPACE}/terraform.tfstate" \
  -backend-config="region=us-east-1" \
  -backend-config="dynamodb_table=tf-lock-secure-clinical"