# Monitoring Module

Deploys CloudWatch alarms and log subscriptions for network observability:

- Alarms on NAT Gateway egress traffic spikes  
- Alarms on VPC Flow Log delivery errors  
- Subscription filter forwarding Flow Logs into a Kinesis Data Firehose stream for long-term archiving

## Inputs

| Name                 | Type         | Description                                    |
|----------------------|--------------|------------------------------------------------|
| nat_gateway_ids      | list(string) | IDs of the NAT Gateways to monitor             |
| flow_log_group_name  | string       | Name of the CloudWatch Log Group for flow logs |
| alarm_sns_topic      | string       | ARN of the SNS topic to notify on alarm state  |

## Outputs

| Name                      | Description                               |
|---------------------------|-------------------------------------------|
| nat_egress_alarm_names    | Names of the NAT Gateway egress alarms    |
| flow_error_alarm_name     | Name of the Flow Log delivery error alarm |
