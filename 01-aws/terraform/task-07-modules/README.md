# Task 07 — Modules 🟡

## Goal
Package reusable configuration into a module and call it multiple times.

## What You'll Build
A local `web-server` module instantiated for two environments.

## Suggested Layout
```
task-07-modules/
├── main.tf            # root: calls the module twice
├── variables.tf
├── outputs.tf
└── modules/
    └── web-server/
        ├── main.tf     # EC2 + security group
        ├── variables.tf
        └── outputs.tf
```

## Steps
1. Build a `web-server` module that takes inputs (instance_type, name, vpc_id,
   subnet_id) and outputs the instance ID and public IP.
2. In the root module, call it twice with `module "web_dev"` and `module "web_prod"`
   passing different instance types.
3. Reference a module output in a root output: `module.web_dev.public_ip`.
4. Run `terraform init` (note it initializes the module) then plan/apply.

## Concepts
- Module inputs and outputs
- Root vs child modules
- Reusing one definition with different inputs
- Module source paths

## Success Criteria
- Two sets of resources created from one module definition.
- Root outputs surface module outputs.

## Cleanup
```bash
terraform destroy
```
