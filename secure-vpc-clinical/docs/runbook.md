# Runbook

## Incident: VPC Flow Log Failure
1. Check CloudWatch alarm `flow-logs-errors`.
2. Inspect log group subscription filter configuration.
3. Validate IAM role permissions for Kinesis Firehose.
4. Apply fix: `terraform apply -target=aws_cloudwatch_log_subscription_filter.to_firehose`.

## Incident: NAT Gateway Outage
1. View `nat-egress-*` alarms in CloudWatch.
2. Check NAT Gateway health status in AWS Console.
3. Fallback to alternative NAT in shared-services VPC.
4. Update Terraform if IP or route issues: `terraform apply -target=module.shared`.

## Incident: Endpoint Failure
1. Test reachability to S3/DynamoDB via VPC endpoints.
2. Review endpoint security group and route tables.
3. Re-create endpoint: `terraform taint aws_vpc_endpoint.s3 && terraform apply`.