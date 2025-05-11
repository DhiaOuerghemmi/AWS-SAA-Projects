output "mgmt_sg" { value = aws_security_group.management.id }
output "app_sg"  { value = aws_security_group.application.id }
output "data_sg" { value = aws_security_group.data.id }
