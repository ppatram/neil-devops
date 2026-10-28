# Task 06 — Iteration with count & for_each 🟡

## Goal
Create multiple similar resources without duplication.

## What You'll Build
Multiple S3 buckets and IAM users created from variables.

## Steps
1. Use `count` to create N numbered S3 buckets from a `bucket_count` variable.
   Reference them with `aws_s3_bucket.this[0]`, etc.
2. Use `for_each` over a `set` of usernames to create `aws_iam_user` resources,
   referencing them by key: `aws_iam_user.this["alice"]`.
3. Use `for_each` over a `map` to create buckets with per-key settings.
4. Use a `for` expression in an output to transform the created resources into a
   list/map.
5. Change an item in the middle of the collection and compare how `count` vs
   `for_each` react in the plan (count re-indexes, for_each does not).

## Concepts
- `count` (numbered) vs `for_each` (keyed)
- Referencing indexed vs keyed resources
- `for` expressions
- Why `for_each` is safer for most real cases

## Success Criteria
- You can explain why removing a middle element differs between count and for_each.

## Cleanup
```bash
terraform destroy
```
