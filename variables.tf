variable "resource_type" {
  type        = string
  description = "Which resource to provision: ec2 or s3"

  validation {
    condition     = contains(["ec2", "s3"], var.resource_type)
    error_message = "resource_type must be either 'ec2' or 's3'."
  }
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
