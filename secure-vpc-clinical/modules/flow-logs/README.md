# VPC Flow Logs Module
Enables VPC Flow Logs to CloudWatch.

## Inputs
| Name   | Type   | Description             |
|--------|--------|-------------------------|
| vpc_id | string | VPC ID to enable logs on|

## Outputs
| Name           | Description             |
|----------------|-------------------------|
| log_group_name | CloudWatch Log Group    |
