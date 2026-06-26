# idp-iacm-poc

Terraform code backing the Harness IDP self-service "Order Infrastructure" workflow.

A single root module provisions **either** an EC2 instance **or** an S3 bucket,
selected by the `resource_type` variable. Harness IaCM drives `init` / `plan` /
`apply` against a per-requester workspace.

## Inputs

| Variable | Description | Default |
|---|---|---|
| `resource_type` | `ec2` or `s3` | (required) |
| `owner_email` | Requester email (used for tagging + naming) | (required) |
| `owner_name` | Requester display name | `""` |
| `region` | AWS region | `us-east-1` |
| `instance_type` | EC2 instance type | `t2.micro` |

## Layout

```
.
├── provider.tf        # AWS + random providers (creds injected by Harness IaCM)
├── variables.tf       # root inputs
├── main.tf            # conditional ec2 / s3 modules
├── outputs.tf         # surfaced as IaCM apply output variables
└── modules/
    ├── ec2/main.tf    # Amazon Linux 2 instance (AMI via data source)
    └── s3/main.tf      # uniquely-named bucket
```

Credentials are supplied by the Harness AWS connector (`aws_connector`), so no
provider credentials are committed here.
