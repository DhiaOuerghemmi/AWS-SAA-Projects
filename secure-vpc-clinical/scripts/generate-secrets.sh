#!/usr/bin/env bash
set -euo pipefail

# Retrieve secret from AWS Secrets Manager
SECRET_NAME="$1"  # TO DO: pass secret name
aws secretsmanager get-secret-value --secret-id "$SECRET_NAME" 