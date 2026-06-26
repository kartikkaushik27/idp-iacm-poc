# idp-iacm-poc

Terraform code + Harness config backing the IDP self-service **"Order Infrastructure"**
workflow.

A developer picks EC2 and/or S3 via an IDP form; a Harness pipeline creates/reuses a
**single IaCM workspace per user** (`<email>_infra`) and runs Terraform to reconcile the
selection. Checking a box creates a resource; unchecking it on a re-run destroys it. Each
run also publishes a per-user **IDP catalog entry** that acts as a manageable table of
provisioned infrastructure.

> **Full design & operations doc:** [`docs/IMPLEMENTATION.md`](docs/IMPLEMENTATION.md)

## Inputs

| Variable | Description | Default |
|---|---|---|
| `create_ec2` | Provision an EC2 instance (`false` removes it) | `false` |
| `create_s3` | Provision an S3 bucket (`false` removes it) | `false` |
| `owner_email` | Requester email (tagging + naming) | (required) |
| `owner_name` | Requester display name | `""` |
| `region` | AWS region | `us-east-1` |
| `instance_type` | EC2 instance type | `t2.micro` |

## Layout

```
.
├── provider.tf            # AWS + random providers (creds injected by Harness IaCM)
├── variables.tf           # root inputs (create_ec2 / create_s3 / owner_*)
├── main.tf                # count-gated ec2 / s3 modules
├── outputs.tf             # surfaced as IaCM apply output variables
├── modules/
│   ├── ec2/main.tf        # Amazon Linux 2 instance (AMI via data source)
│   └── s3/main.tf         # uniquely-named bucket
├── workflow.yaml          # IDP Workflow (Backstage format)
├── workflow_harness.yaml  # IDP Workflow (harness.io/v1 native format)
├── group_platform_team.yaml
├── harness/
│   └── provision_infra.pipeline.yaml   # the pipeline (source of truth)
└── docs/
    └── IMPLEMENTATION.md  # detailed implementation guide
```

Credentials are supplied by the Harness AWS connector (`aws_connector`); the STS
`AWS_SESSION_TOKEN` is injected into the workspace as a secret env var. No provider
credentials are committed here.
