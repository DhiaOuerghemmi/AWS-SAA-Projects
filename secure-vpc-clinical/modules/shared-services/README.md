# Shared-Services VPC Module

Provision a centralized “shared-services” VPC that hosts:

- Public subnets and high-availability NAT Gateways across multiple AZs  
- Gateway Endpoints for S3 and DynamoDB to eliminate NAT egress costs  
- VPC Peering connections to one or more consumer VPCs

## Inputs

| Name          | Type         | Description                               |
|---------------|--------------|-------------------------------------------|
| name          | string       | Prefix for all shared-services resources  |
| cidr_block    | string       | CIDR block for the shared-services VPC    |
| azs           | list(string) | List of Availability Zones                |
| public_cidrs  | list(string) | CIDR blocks for public subnets            |
| peer_vpc_ids  | list(string) | IDs of VPCs to peer with this shared VPC  |

## Outputs

| Name              | Description                                    |
|-------------------|------------------------------------------------|
| shared_vpc_id     | The ID of the shared-services VPC              |
| nat_gateway_ids   | List of NAT Gateway IDs (one per AZ)           |
| vpc_peering_ids   | List of VPC Peering Connection IDs             |
