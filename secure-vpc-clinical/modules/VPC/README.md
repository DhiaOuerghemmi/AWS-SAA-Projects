# VPC Module
Creates a multi‑AZ VPC with public and private subnets.

## Inputs
| Name         | Type         | Description              |
|--------------|--------------|--------------------------|
| name         | string       | Prefix for all resources |
| cidr_block   | string       | VPC CIDR block           |
| azs          | list(string) | AZ list                  |
| public_cidrs | list(string) | Public subnet CIDRs      |
| private_cidrs| list(string) | Private subnet CIDRs     |

## Outputs
| Name            | Description           |
|-----------------|-----------------------|
| vpc_id          | The VPC ID            |
| public_subnets  | IDs of public subnets |
| private_subnets | IDs of private subnets|
