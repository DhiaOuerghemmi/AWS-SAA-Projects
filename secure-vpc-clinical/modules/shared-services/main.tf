resource "aws_vpc" "shared" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "${var.name}-shared" }
}

resource "aws_subnet" "public" {
  count                   = length(var.azs)
  vpc_id                  = aws_vpc.shared.id
  availability_zone       = var.azs[count.index]
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  tags = { Name = "${var.name}-public-${count.index}" }
}

resource "aws_eip" "nat" {
  count = length(var.azs)
  vpc   = true
}

resource "aws_nat_gateway" "nat" {
  count         = length(var.azs)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = { Name = "${var.name}-nat-${count.index}" }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.shared.id
  service_name = "com.amazonaws.${var.region}.s3"
  route_table_ids = [aws_vpc.shared.default_route_table_id]
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id       = aws_vpc.shared.id
  service_name = "com.amazonaws.${var.region}.dynamodb"
  route_table_ids = [aws_vpc.shared.default_route_table_id]
}

resource "aws_vpc_peering_connection" "peer" {
  count       = length(var.peer_vpc_ids)
  vpc_id      = aws_vpc.shared.id
  peer_vpc_id = var.peer_vpc_ids[count.index]
  auto_accept = true
  tags = { Name = "${var.name}-peer-${count.index}" }
}
