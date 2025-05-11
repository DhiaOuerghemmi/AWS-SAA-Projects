#!/usr/bin/env bash
set -euo pipefail

echo "Running pre-commit Terraform checks..."
terraform fmt -check
terraform validate