# Task 03 — Understanding State 🟢

## Goal
Learn what Terraform state is and how to inspect and manipulate it.

## What You'll Build
Reuse the Task 02 config; focus on the state file, not new resources.

## Steps
1. After an `apply`, open `terraform.tfstate` and read it (do not edit by hand).
2. Inspect state with:
   ```bash
   terraform state list
   terraform state show aws_s3_bucket.this
   terraform show
   ```
3. Create an S3 bucket manually in the console, then `terraform import` it into
   a new resource address and write matching config for it.
4. Create **drift**: change a tag on a managed bucket in the console, then run
   `terraform plan` to see Terraform detect the difference.
5. Practice `terraform state mv` to rename a resource address without destroying it.

## Concepts
- What state is and why it exists
- State inspection commands
- `terraform import`
- Drift detection
- `terraform state mv`

## Success Criteria
- You can explain what the state file stores.
- You successfully import an existing bucket.
- `plan` shows drift after a console change.

## Cleanup
```bash
terraform destroy
```
> Note: manually-created resources you imported will also be destroyed.
