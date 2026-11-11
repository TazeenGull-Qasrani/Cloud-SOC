# Cloud SOC Infrastructure — Terraform

A beginner-friendly AWS Cloud SOC infrastructure managed with Terraform for a university Security Operations project. Stage 1 provides the deployed network and storage foundation. Stage 2 is currently limited to design, Terraform validation, and a no-additional-resource plan.

---

## Architecture

```
Internet
   │
   ▼
Internet Gateway (cloudsoc-igw)
   │
   ▼
VPC 10.0.0.0/16  (cloudsoc-vpc)
└── Public Subnet 10.0.1.0/24  (cloudsoc-public-subnet)
    └── Web security group (HTTP port 80 rule; no Stage 2 instance attached)

S3 Bucket (cloudsoc-logs-<account-id>)
    └── Private, encrypted, versioned; 30-day lifecycle retention
```

Stage 2 does not launch EC2 or add another AWS resource while zero-credit eligibility is unverified. CloudTrail and VPC Flow Logs are later-stage work and are not configured here.

## Deferred Stage 2 design (documentation only)

The previously considered compute design was Ubuntu Server 24.04 LTS AMD64 from Canonical, a `t3.micro`, an encrypted 8 GiB gp3 root volume, IMDSv2, and Nginx serving a demo page over HTTP 80 with no SSH access. This is design documentation only: there is no active EC2 resource, AMI lookup, or compute output in Terraform. Do not deploy it unless the account-specific cost and Free Plan eligibility are verified and deployment is separately approved.

---

## Project Files

| File | Purpose |
|------|---------|
| `providers.tf` | AWS provider + version constraints |
| `variables.tf` | All input variables with descriptions |
| `main.tf` | All resource definitions |
| `outputs.tf` | Useful output values after deploy |
| `terraform.tfvars` | Your actual variable values (git-ignored) |
| `terraform.tfvars.example` | Template — copy & edit |
| `.gitignore` | Excludes secrets and state from git |

---

## Prerequisites

- Terraform ≥ 1.5.0 installed
- AWS IAM user credentials set in PowerShell environment variables

---

## Deployment Steps

### 1. Configure your variables

Review and adjust `terraform.tfvars`:
- `s3_bucket_name` → globally unique name (configured as `cloudsoc-logs-168629931426`)

### 2. Initialize

```powershell
cd "E:\Sem7\SecOps\Project"
terraform init
```

### 3. Format and validate

```powershell
terraform fmt
terraform validate
```

### 4. Plan (review before applying)

```powershell
terraform plan
```

### 5. Deployment guard

For the current zero-additional-resource Stage 2, the reviewed plan should report `0 to add, 0 to change, 0 to destroy`. Do not apply a plan that proposes resource changes; a deployment requires a separate cost review and explicit approval.

---

## Verifying the Deployed Stage 1 Infrastructure

To view the existing Terraform outputs, run:

```powershell
terraform output
```

### Verification checklist

| Check | Command / Method |
|-------|-----------------|
| VPC exists | AWS Console → VPC → Your VPCs |
| Public subnet exists | AWS Console → VPC → Subnets |
| Internet Gateway attached | AWS Console → VPC → Internet Gateways |
| Route table has 0.0.0.0/0 → IGW | AWS Console → VPC → Route Tables |
| Security group rules correct | AWS Console → EC2 → Security Groups (HTTP 80 allowed, no SSH rule) |
| S3 bucket is private | AWS Console → S3 → Bucket → Permissions |
| S3 encryption enabled | AWS Console → S3 → Bucket → Properties |
| CloudTrail and VPC Flow Logs | Not part of the current stages |

---

## Cost considerations

The current Stage 2 configuration adds no AWS resources. The existing VPC components have no separate hourly resource charge, but internet data transfer can be billed. The S3 bucket is usage-priced; a read-only inventory found no object versions or object bytes at the time checked, but future storage and requests can incur charges. AWS Free Plan credits and eligibility are account-specific, so this project does not claim that future services are free. EC2, public IPv4, EBS, NAT Gateway, CloudTrail, VPC Flow Logs, CloudWatch Logs, WAF, and customer-managed KMS keys are excluded from the current plan.

---

## Cleanup (Destroy All Resources)

Do not run this as part of the no-additional-resource Stage 2 workflow: it would target the existing Stage 1 infrastructure.

```powershell
cd "E:\Sem7\SecOps\Project"
terraform destroy
# Type 'yes' when prompted
```
