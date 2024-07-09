variable "bucket_prefix" {
  description = "A prefix used to name the bucket (e.g., logs, tfstate). The final name will be auto-generated by AWS to ensure uniqueness."
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prd) for tagging purposes."
  type        = string
}