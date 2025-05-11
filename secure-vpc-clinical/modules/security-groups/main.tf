variable "vpc_id" { type = string }
variable "allowed_cidrs" { type = list(string) }

resource "aws_security_group" "management" {
  name        = "sg-management"
  vpc_id      = var.vpc_id
  description = "Mgmt tier"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }
  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
}

resource "aws_security_group" "application" {
  name        = "sg-app"
  vpc_id      = var.vpc_id
  description = "App tier"
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.management.id]
  }
  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
}

resource "aws_security_group" "data" {
  name        = "sg-data"
  vpc_id      = var.vpc_id
  description = "Data tier"
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.application.id]
  }
  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
}
