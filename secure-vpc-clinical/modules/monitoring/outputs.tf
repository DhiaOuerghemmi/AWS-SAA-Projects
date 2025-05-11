output "nat_alarms"      { value = aws_cloudwatch_metric_alarm.nat_egress[*].alarm_name }
output "flow_error_alarm"{ value = aws_cloudwatch_metric_alarm.flow_errors.alarm_name }
