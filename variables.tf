variable "create_ec2" {
  type        = bool
  description = "Provision an EC2 instance. Set false to remove a previously created instance."
  default     = false
}

variable "create_s3" {
  type        = bool
  description = "Provision an S3 bucket. Set false to remove a previously created bucket."
  default     = false
}

variable "owner_email" {
  type        = string
  description = "Email of the developer requesting the infrastructure"
}

variable "owner_name" {
  type        = string
  description = "Display name of the requester (used for tagging)"
  default     = ""
}

variable "region" {
  type        = string
  description = "AWS region to provision into"
  default     = "us-east-1"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type (only used when resource_type = ec2)"
  default     = "t2.micro"
}
