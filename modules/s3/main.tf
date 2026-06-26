variable "owner_email" {
  type = string
}

variable "owner_name" {
  type    = string
  default = ""
}

# Bucket names must be globally unique; derive a stable prefix from the email
# local-part and append a random suffix.
resource "random_id" "suffix" {
  byte_length = 4
}

locals {
  email_local = lower(replace(split("@", var.owner_email)[0], ".", "-"))
  bucket_name = "idp-${local.email_local}-${random_id.suffix.hex}"
}

resource "aws_s3_bucket" "this" {
  bucket = local.bucket_name

  tags = {
    Owner     = var.owner_email
    OwnerName = var.owner_name
    ManagedBy = "harness-idp-iacm"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.this.id
}

output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}
