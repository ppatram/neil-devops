# Task 11 — Dynamic Blocks & Advanced Expressions 🔴

## Goal
Build flexible, data-driven configuration with dynamic blocks and functions.

## What You'll Build
A security group whose ingress rules are generated from a variable.

## Steps
1. Define a variable `ingress_rules` as a list of objects:
   ```hcl
   variable "ingress_rules" {
     type = list(object({
       port        = number
       protocol    = string
       cidr_blocks = list(string)
       description  = string
     }))
   }
   ```
2. Use a `dynamic "ingress"` block inside `aws_security_group` to generate one
   rule per list item.
3. Practice advanced expressions:
   - Conditional: `var.enable_https ? 443 : 80`
   - `for` expression to transform a list into a map
   - `try()` for safe lookups
   - Functions: `merge()`, `lookup()`, `flatten()`, `toset()`, `coalesce()`
4. Output the final computed rule set.

## Concepts
- `dynamic` blocks for repeated nested blocks
- Conditional expressions
- `for` expressions (list and map comprehensions)
- Built-in functions and `try()`

## Success Criteria
- Adding an item to `ingress_rules` adds a rule with no code change.
- You can explain when a dynamic block helps vs hurts readability.

## Cleanup
```bash
terraform destroy
```
