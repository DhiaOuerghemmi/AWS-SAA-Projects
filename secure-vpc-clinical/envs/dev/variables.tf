variable "profile_dev" {
  description = "AWS CLI profile for dev"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the dev VPC"
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