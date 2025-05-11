# AWS Budget at 80% of monthly spend :contentReference[oaicite:4]{index=4}
resource "aws_budgets_budget" "monthly" {
  name         = "monthly-cost-budget"
  budget_type  = "COST"
  limit_amount = "500"
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    notification_type          = "ACTUAL"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    subscriber_email_addresses = ["ops-team@example.com"]  # TO DO
  }
}
