# ──────────────────────────────────────────────────────────────────────────────
# Networking
# ──────────────────────────────────────────────────────────────────────────────
output "vpc_id" {
  description = "ID of the CloudSOC VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "security_group_id" {
  description = "ID of the public web security group"
  value       = aws_security_group.web.id
}

# ──────────────────────────────────────────────────────────────────────────────
# Storage
# ──────────────────────────────────────────────────────────────────────────────
output "s3_bucket_name" {
  description = "Name of the private security-logs S3 bucket"
  value       = aws_s3_bucket.security_logs.id
}

output "s3_bucket_arn" {
  description = "ARN of the security-logs S3 bucket"
  value       = aws_s3_bucket.security_logs.arn
}

# ──────────────────────────────────────────────────────────────────────────────
# Account info
# ──────────────────────────────────────────────────────────────────────────────
output "aws_account_id" {
  description = "AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "authenticated_iam_user" {
  description = "ARN of the IAM principal running Terraform"
  value       = data.aws_caller_identity.current.arn
}
