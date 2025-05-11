# Requirements and Compliance

## Stakeholder Needs
- **Isolation**: Each clinical workload must run in its own multi-AZ VPC to prevent cross-environment data leaks.
- **High Availability**: Achieve at least 99.9% uptime for critical clinical services.
- **Security**: PHI must be encrypted in transit and at rest; access strictly controlled via IAM and network controls.
- **Auditability**: Maintain VPC Flow Logs, CloudTrail, and AWS Config logs for 365 days to satisfy audit and compliance.
- **Scalability**: Infrastructure should scale with patient volume without manual intervention.

## HIPAA Controls
- **164.312(a)(2)(iv)**: Encrypt PHI in transit (TLS enforced on endpoints).
- **164.312(e)(1)**: Implement transmission security via VPC endpoint and NAT gateway configurations.
- **164.308(b)(2)**: Access controls via IAM roles, Security Groups, and SCPs.
- **164.312(b)**: Integrity controls through CloudWatch alarms and automated remediation.