# A single workspace per requester (<email>_infra) holds the full desired state.
# Each module is gated by a boolean flag, so the apply reconciles to exactly what
# the requester selected in IDP: checking a box creates the resource, unchecking
# it on a later run sets count = 0 and Terraform destroys it.

module "ec2" {
  source        = "./modules/ec2"
  count         = var.create_ec2 ? 1 : 0
  owner_email   = var.owner_email
  owner_name    = var.owner_name
  instance_type = var.instance_type
}

module "s3" {
  source      = "./modules/s3"
  count       = var.create_s3 ? 1 : 0
  owner_email = var.owner_email
  owner_name  = var.owner_name
}
