# ──────────────────────────────────────────────────────────────────────────────
# General
# ──────────────────────────────────────────────────────────────────────────────
variable "aws_region" {
  description = "AWS region to deploy resources into."
  type        = string
  default     = "ap-southeast-2"
}

variable "project_name" {
  description = "Short name used to prefix resource names and tags."
  type        = string
  default     = "cloudsoc"
}

# ──────────────────────────────────────────────────────────────────────────────
# Networking
# ──────────────────────────────────────────────────────────────────────────────
variable "vpc_cidr" {
  description = "IPv4 CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "IPv4 CIDR block for the public subnet."
  type        = string
  default     = "10.0.1.0/24"
}

# ──────────────────────────────────────────────────────────────────────────────
# Storage
# ──────────────────────────────────────────────────────────────────────────────
variable "s3_bucket_name" {
  description = <<-EOT
    Globally unique name for the private S3 security-logs bucket.
    Must be lowercase, 3–63 characters, no uppercase or underscores.
    Recommended pattern: cloudsoc-logs-<12-digit-aws-account-id>
    Set this in terraform.tfvars — do not use the generic default.
  EOT
  type        = string
}
