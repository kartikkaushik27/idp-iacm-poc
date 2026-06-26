# Root outputs are surfaced by the IaCM apply step as output variables, e.g.
# <+pipeline.stages.provision.spec.execution.steps.apply.output.outputVariables.public_ip>

output "id" {
  description = "EC2 instance id (empty for s3 requests)"
  value       = try(module.ec2[0].id, "")
}

output "public_ip" {
  description = "EC2 public IP (empty for s3 requests)"
  value       = try(module.ec2[0].public_ip, "")
}

output "private_ip" {
  description = "EC2 private IP (empty for s3 requests)"
  value       = try(module.ec2[0].private_ip, "")
}

output "instance_state" {
  description = "EC2 instance state (empty for s3 requests)"
  value       = try(module.ec2[0].instance_state, "")
}

output "bucket_name" {
  description = "S3 bucket name (empty for ec2 requests)"
  value       = try(module.s3[0].bucket_name, "")
}

output "bucket_arn" {
  description = "S3 bucket ARN (empty for ec2 requests)"
  value       = try(module.s3[0].bucket_arn, "")
}
