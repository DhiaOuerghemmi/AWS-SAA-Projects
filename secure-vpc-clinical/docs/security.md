# Security Rationale

- **Network Segmentation**: Three-tier subnets (management, application, data) isolate traffic.
- **Least Privilege**: IAM roles scoped to each environment; SCPs prevent policy violations.
- **Logging & Monitoring**: Centralized logs with 90-day retention, CloudWatch alarms, and automated remediations.
- **Encryption**: KMS-managed keys for S3, EBS, and Terraform state; TLS enforced on all endpoints.
- **Policy as Code**: Sentinel and AWS Config rules block non-compliant changes pre-apply.