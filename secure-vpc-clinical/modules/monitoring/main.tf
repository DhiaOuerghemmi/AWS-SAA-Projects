# NAT Gateway egress alarm
resource "aws_cloudwatch_metric_alarm" "nat_egress" {
  for_each           = toset(var.nat_gateway_ids)
  alarm_name         = "nat-egress-${each.key}"
  namespace          = "AWS/NATGateway"
  metric_name        = "BytesOutToDestination"
  statistic          = "Sum"
  period             = 300
  evaluation_periods = 1
  threshold          = 1000000000   # TO DO: ajuster selon vos besoins
  dimensions = { NatGatewayId = each.key }
  alarm_actions = [var.alarm_sns_topic]
}

# Flow Log delivery errors
resource "aws_cloudwatch_metric_alarm" "flow_errors" {
  alarm_name         = "flow-logs-errors"
  namespace          = "AWS/Logs"
  metric_name        = "DeliveryErrors"
  statistic          = "Sum"
  period             = 300
  evaluation_periods = 1
  threshold          = 1
  dimensions = { LogGroupName = var.flow_log_group_name }
  alarm_actions = [var.alarm_sns_topic]
}

# Subscription filter to Firehose (central archive)
resource "aws_cloudwatch_log_subscription_filter" "to_firehose" {
  name           = "flowlogs-to-firehose"
  log_group_name = var.flow_log_group_name
  filter_pattern = ""
  destination_arn = aws_kinesis_firehose_delivery_stream.firehose.arn  # TO DO: créer ce stream
  role_arn        = aws_iam_role.firehose_role.arn                    # TO DO: créer ce rôle
}
