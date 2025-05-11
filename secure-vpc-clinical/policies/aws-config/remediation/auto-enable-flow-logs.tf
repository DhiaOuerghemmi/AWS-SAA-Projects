# Remediation for VPC Flow Logs (enables flow logs if disabled)
resource "aws_config_remediation_configuration" "enable_vpc_flow_logs" {
  config_rule_name = "vpc-flow-logs-enabled"  # AWS Config rule name
  target_type      = "AWS::EC2::FlowLog"
  target_id        = "AWS-EnableVPCFlowLogs"     # AWS managed remediation action

  automatic = true
  maximum_automatic_attempts = 1

  parameters = {
    ConfigRuleName = {
      static_value = {
        values = ["vpc-flow-logs-enabled"]
      }
    }
    FlowLogId = {
      resource_value = {
        resource_type = "AWS::EC2::VPC"
      }
    }
  }
}

# Remediation for Restricted CIDRs (removes non-compliant ingress rules)
resource "aws_config_remediation_configuration" "restrict_cidrs_remediation" {
  config_rule_name = "restricted-cidrs"
  target_type      = "AWS::EC2::SecurityGroupRule"
  target_id        = "AWS-RemoveSecurityGroupRule"  # AWS managed remediation action

  automatic = true
  maximum_automatic_attempts = 1

  parameters = {
    ConfigRuleName = {
      static_value = {
        values = ["restricted-cidrs"]
      }
    }
  }
}