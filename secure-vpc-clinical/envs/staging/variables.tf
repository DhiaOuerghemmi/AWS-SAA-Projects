// environments/staging/variables.tf
variable "profile_staging" {
  description = "AWS CLI profile for staging"
  type        = string
}
ariable "vpc_cidr" {
  description = "CIDR block for the staging VPC"
  type        = string
}

variable "azs" {
  description = "List of AZs"
  type        = list(string)
}

variable "public_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "private_cidrs" {
  description = "Private subnet CIDRs"
  type        = list(string)
}