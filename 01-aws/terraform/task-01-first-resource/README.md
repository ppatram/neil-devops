# Task 01 — Your First Resource 🟢

## Goal
Write the smallest possible Terraform config and run the full lifecycle.

## What You'll Build
A single S3 bucket managed by Terraform.

## Steps
1. Create `main.tf` with:
   - A `terraform { required_providers { ... } }` block pinning the AWS provider.
   - A `provider "aws"` block setting the region.
   - A single `aws_s3_bucket` resource with a globally-unique name.
2. Run the core workflow:
   ```bash
   terraform init
   terraform fmt
   terraform validate
   terraform plan
   terraform apply
   ```
3. Verify the bucket exists in the AWS Console.
4. Tear it down:
   ```bash
   terraform destroy
   ```

## Concepts
- Provider / resource model
- HCL block syntax
- The init → plan → apply → destroy lifecycle

## Success Criteria
- `terraform apply` creates the bucket with no errors.
- `terraform destroy` removes it and leaves empty state.

## Cleanup
```bash
terraform destroy
```
