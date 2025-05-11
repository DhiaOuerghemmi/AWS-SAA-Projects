variable "profile_prod" {
  description = "AWS CLI profile for prod"
  type        = string
}
variable "prod_role_arn" {
  description = "IAM role ARN to assume for prod deployments"
  type        = string
}
// (other variables same as dev)
