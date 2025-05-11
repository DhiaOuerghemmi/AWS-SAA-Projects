# Module Overview

| Module            | Purpose                                                        |
|-------------------|----------------------------------------------------------------|
| **vpc**           | Creates core VPC, public and private subnets                   |
| **subnets**       | Manages subnet resources across AZs                            |
| **nat-gateway**   | Provisions high-availability NAT Gateways per AZ               |
| **flow-logs**     | Enables VPC Flow Logs to CloudWatch with IAM role             |
| **shared-services**| Central VPC for shared NAT, endpoints, and peering            |
| **monitoring**    | CloudWatch alarms for NAT egress and Flow Log errors; log export |

For detailed input/output, see each module's `README.md`.