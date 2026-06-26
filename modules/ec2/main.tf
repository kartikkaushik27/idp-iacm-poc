variable "owner_email" {
  type = string
}

variable "owner_name" {
  type    = string
  default = ""
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

# Look up the latest Amazon Linux 2 AMI so we never hardcode a region-specific id.
data "aws_ami" "al2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.al2.id
  instance_type = var.instance_type

  tags = {
    Name      = var.owner_name != "" ? "idp-${var.owner_name}" : "idp-instance"
    Owner     = var.owner_email
    OwnerName = var.owner_name
    ManagedBy = "harness-idp-iacm"
  }
}

output "id" {
  value = aws_instance.this.id
}

output "public_ip" {
  value = aws_instance.this.public_ip
}

output "private_ip" {
  value = aws_instance.this.private_ip
}

output "instance_state" {
  value = aws_instance.this.instance_state
}
