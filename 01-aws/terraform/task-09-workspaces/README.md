# Task 09 — Workspaces & Multi-Environment 🟡

## Goal
Manage multiple environments and understand the trade-offs of each approach.

## What You'll Build
One config deployed to `dev` and `prod` workspaces with different sizing.

## Steps
1. Start from a simple config (e.g. an EC2 instance).
2. Create and switch workspaces:
   ```bash
   terraform workspace new dev
   terraform workspace new prod
   terraform workspace select dev
   terraform workspace list
   ```
3. Use `terraform.workspace` in the config to vary values:
   ```hcl
   locals {
     instance_type = terraform.workspace == "prod" ? "t3.large" : "t3.micro"
     name          = "app-${terraform.workspace}"
   }
   ```
4. Apply in `dev`, switch to `prod`, apply again. Note each workspace has its own
   state.
5. **Discussion:** write notes comparing workspaces vs the directory-per-env
   pattern (separate backends/folders). Workspaces share one backend; separate
   dirs give stronger isolation and are usually preferred for prod.

## Concepts
- `terraform workspace` commands
- `terraform.workspace` interpolation
- Per-workspace state
- Workspaces vs directory-per-environment trade-offs

## Success Criteria
- `dev` and `prod` produce differently-sized resources from one config.
- You can articulate when NOT to use workspaces.

## Cleanup
```bash
terraform workspace select dev && terraform destroy
terraform workspace select prod && terraform destroy
```
