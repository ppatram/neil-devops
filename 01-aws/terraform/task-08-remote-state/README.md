# Task 08 — Remote State with S3 & DynamoDB 🟡

## Goal
Move state off your laptop into a shared, locked remote backend.

## What You'll Build
An S3 bucket + DynamoDB lock table, then migrate an existing config to use them.

## Steps
1. In a **bootstrap** step (local state), create:
   - An `aws_s3_bucket` for state (versioning enabled, encryption on, public
     access blocked).
   - An `aws_dynamodb_table` with a `LockID` string hash key for locking.
2. Add a `backend "s3"` block to a separate config pointing at that bucket and
   table:
   ```hcl
   terraform {
     backend "s3" {
       bucket         = "my-tf-state-bucket"
       key            = "task08/terraform.tfstate"
       region         = "us-east-1"
       dynamodb_table = "my-tf-locks"
       encrypt        = true
     }
   }
   ```
3. Run `terraform init` and migrate state when prompted.
4. Start an `apply`, and in a second terminal start another — observe the lock
   preventing the concurrent run.

## Concepts
- Remote backends
- State locking (DynamoDB)
- State encryption and versioning
- `terraform init` migration

## Success Criteria
- State no longer lives locally.
- A second concurrent apply is blocked by the lock.

## Cleanup
Destroy app resources first, then empty the state bucket and destroy the
bootstrap resources last. (The state bucket must be emptied before deletion.)
