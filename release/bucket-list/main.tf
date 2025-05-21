variable "bucket_name" {
  type        = string
  description = "Name of the bucket with the objects to be listed"
}

variable "prefix" {
  type        = string
  description = "S3 key prefix used to filter objects in the bucket"
  default     = ""
}

variable "max_keys" {
  type        = string
  description = "Max number of objects to retrieve"
  default     = 99999
}

data "aws_s3_objects" "this" {
  bucket   = var.bucket_name
  prefix   = var.prefix
  max_keys = var.max_keys
}

output "s3_objects" {
  value = data.aws_s3_objects.this
}
