# Architecture Overview

![Terraform Graph](./architecture-graph.png)

1. **Shared-Services VPC**: Centralizes NAT Gateways and Gateway Endpoints for cost efficiency.
2. **Environment VPCs**: Dev, Staging, and Prod VPCs consume shared-services via VPC Peering.
3. **Monitoring & Logging**: VPC Flow Logs -> CloudWatch -> S3 via Kinesis Firehose, with alarms on anomalies.
4. **Compliance Policies**: AWS Config rules and Sentinel policies enforce drift detection and remediation.