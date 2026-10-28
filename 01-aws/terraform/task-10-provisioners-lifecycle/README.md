# Task 10 — Provisioners & Lifecycle Rules 🔴

## Goal
Learn the escape hatches and how to control Terraform's default behavior.

## What You'll Build
An EC2 instance with provisioners and various lifecycle rules.

## Steps
1. Add a `provisioner "local-exec"` that writes the instance IP to a local file
   on creation.
2. Add a `provisioner "remote-exec"` (via SSH connection block) that runs a
   bootstrap command. **Note:** prefer `user_data` over provisioners in real
   life — this task is to understand them, not endorse them.
3. Use a `null_resource` with a `triggers` map that re-runs a `local-exec` when a
   value changes.
4. Experiment with `lifecycle` meta-arguments:
   - `create_before_destroy = true` (zero-downtime replacement)
   - `prevent_destroy = true` (then try to destroy and see it blocked)
   - `ignore_changes = [tags]` (change a tag in console, see it ignored)

## Concepts
- `local-exec` / `remote-exec` provisioners and their pitfalls
- `null_resource` + triggers
- `lifecycle`: create_before_destroy, prevent_destroy, ignore_changes
- Why `user_data`/config management usually beats provisioners

## Success Criteria
- You can explain when provisioners are a last resort.
- `prevent_destroy` blocks a destroy; `ignore_changes` suppresses drift.

## Cleanup
Remove `prevent_destroy` first, then:
```bash
terraform destroy
```
