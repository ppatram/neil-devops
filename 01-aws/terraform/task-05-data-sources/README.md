# Task 05 — Data Sources 🟡

## Goal
Query existing/external infrastructure instead of hardcoding values.

## What You'll Build
An EC2 instance whose AMI, AZ, and VPC are all looked up dynamically.

## Steps
1. Use `data "aws_ami"` with filters to find the latest Amazon Linux 2023 AMI.
2. Use `data "aws_availability_zones"` to list AZs in the region.
3. Use `data "aws_caller_identity"` and `data "aws_region"` to read account/region.
4. Use `data "aws_vpc"` with `default = true` to reference the default VPC.
5. Launch an `aws_instance` using the looked-up AMI and first AZ.
6. Output the account ID, region, and resolved AMI ID.

## Concepts
- `data` blocks
- Filtering and sorting data source results
- Keeping config portable across regions/accounts

## Success Criteria
- No hardcoded AMI IDs anywhere.
- The same config works if you change the region.

## Cleanup
```bash
terraform destroy
```
