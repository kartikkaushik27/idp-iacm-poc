# One root module, two resource types. The resource_type workspace variable
# selects which module is instantiated. Because each requester+type maps to its
# own workspace (and therefore its own state), provisioning EC2 never disturbs a
# previously created S3 bucket for the same user.

module "ec2" {
  source        = "./modules/ec2"
  count         = var.resource_type == "ec2" ? 1 : 0
  owner_email   = var.owner_email
  owner_name    = var.owner_name
  instance_type = var.instance_type
}

module "s3" {
  source      = "./modules/s3"
  count       = var.resource_type == "s3" ? 1 : 0
  owner_email = var.owner_email
  owner_name  = var.owner_name
}
