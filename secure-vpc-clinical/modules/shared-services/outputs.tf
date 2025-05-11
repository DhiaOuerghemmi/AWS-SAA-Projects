output "shared_vpc_id" {
  value = aws_vpc.shared.id
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.shared_nat[*].id
}

output "vpc_peering_ids" {
  value = aws_vpc_peering_connection.peer[*].id
}
