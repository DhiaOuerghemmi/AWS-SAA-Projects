variable "vpc_id"        { description = "VPC ID";       type = string }
variable "allowed_cidrs" { description = "CIDRs allowed"; type = list(string) }
