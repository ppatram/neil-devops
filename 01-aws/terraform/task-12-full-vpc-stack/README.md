# Task 12 — Full VPC + Application Stack (Capstone) 🔴

## Goal
Combine everything into a production-style, multi-tier AWS architecture.

## What You'll Build
```
Internet
   │
[ Internet Gateway ]
   │
[ Application Load Balancer ]  (public subnets, multi-AZ)
   │
[ Auto Scaling Group of EC2 ]  (private subnets, multi-AZ)
   │
[ NAT Gateway ] ── outbound internet for private subnets
```

Components:
- VPC with public + private subnets across 2+ AZs (use `for_each`/`count` + AZ
  data source)
- Internet Gateway, NAT Gateway, route tables
- Application Load Balancer + target group + listener
- Launch template + Auto Scaling Group in private subnets
- Security groups (ALB SG allows 80/443 from internet; app SG allows traffic
  only from the ALB SG) — build rules with a `dynamic` block
- Remote state backend (reuse Task 08)
- Per-environment variables and clean outputs (ALB DNS name)

## Suggested Layout
```
task-12-full-vpc-stack/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── modules/
    ├── network/      # VPC, subnets, IGW, NAT, routes
    ├── alb/          # ALB, target group, listener
    └── compute/      # launch template, ASG, app SG
```

## Steps
1. Build the `network` module first; output subnet IDs and VPC ID.
2. Build `alb` and `compute` modules consuming the network outputs.
3. Wire security groups so only the ALB can reach the instances.
4. Use the S3/DynamoDB remote backend from Task 08.
5. `plan`, `apply`, then hit the ALB DNS name output in your browser.

## Concepts
Ties together: modules, `for_each`/`count`, data sources, remote state, dynamic
blocks, dependencies, outputs — the full toolkit.

## Success Criteria
- The ALB DNS name serves traffic from the ASG instances.
- Private instances have no public IPs but can reach the internet via NAT.

## Cleanup (IMPORTANT — this stack is billable)
```bash
terraform destroy
```
> The **NAT Gateway** and **ALB** bill per hour. Destroy promptly after testing.
