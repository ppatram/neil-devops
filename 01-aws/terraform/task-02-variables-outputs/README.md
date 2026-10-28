# Task 02 — Variables, Outputs & Locals 🟢

## Goal
Make the Task 01 bucket configurable and expose its attributes.

## What You'll Build
A parameterized S3 bucket whose name, region, and tags come from variables.

## Steps
1. Create `variables.tf` with input variables:
   - `bucket_name` (string, with a `validation` rule)
   - `region` (string, default `us-east-1`)
   - `tags` (map(string), default `{}`)
2. Add a `locals` block that builds a merged tag set (e.g. adds `ManagedBy = "terraform"`).
3. Reference the variables/locals in `main.tf`.
4. Create `outputs.tf` exposing the bucket ARN and ID.
5. Create `terraform.tfvars` to supply values; also try overriding with
   `-var` and `TF_VAR_` environment variables to see precedence.
6. Run the workflow and read the outputs.

## Concepts
- Input variables (types, defaults, validation)
- `locals` for computed values
- `output` values
- Variable precedence (tfvars vs CLI vs env)

## Success Criteria
- Changing a variable changes the plan.
- Outputs print after apply.

## Cleanup
```bash
terraform destroy
```
