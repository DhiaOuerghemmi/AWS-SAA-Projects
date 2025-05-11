# Security Groups Module
Creates three-tier security groups (management, application, data).

## Inputs
| Name          | Type         | Description           |
|---------------|--------------|-----------------------|
| vpc_id        | string       | VPC to attach to      |
| allowed_cidrs | list(string) | CIDRs for SSH access  |

## Outputs
| Name     | Description         |
|----------|---------------------|
| mgmt_sg  | Management SG ID    |
| app_sg   | Application SG ID   |
| data_sg  | Data tier SG ID     |
