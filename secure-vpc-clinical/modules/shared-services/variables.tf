variable "name" {
  description = "Prefix for shared-services VPC"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for shared-services VPC"
  type        = string
}

variable "azs" {
  description = "List of AZs for subnets"
  type        = list(string)
}

variable "public_cidrs" {
  description = "CIDRs for public subnets"
  type        = list(string)
}

variable "peer_vpc_ids" {
  description = "List of VPC IDs to peer with shared-services VPC"
  type        = list(string)
}
