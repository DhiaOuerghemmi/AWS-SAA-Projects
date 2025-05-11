variable "name"       { description = "Resource prefix"; type = string }
variable "cidr_block" { description = "VPC CIDR block"; type = string }
variable "azs"        { description = "List of AZs"; type = list(string) }
variable "public_cidrs"  { description = "CIDRs for public subnets"; type = list(string) }
variable "private_cidrs" { description = "CIDRs for private subnets"; type = list(string) }
