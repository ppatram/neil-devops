# Terraform Hands-On Tasks (AWS)

A progressive set of hands-on labs for learning Terraform on AWS, ordered from
**easy → medium → complex**. Each task lives in its own folder and builds on
concepts from the previous ones. Work through them in order.

By the end you will have touched every core Terraform concept: providers,
resources, variables, outputs, state, remote backends, data sources, iteration,
modules, workspaces, lifecycle rules, dynamic blocks, and a full multi-resource
architecture.

---

## Prerequisites

Before starting, make sure you have:

- **Terraform** installed (`terraform -version`, v1.6+ recommended)
- **AWS CLI** installed and configured (`aws configure`) with credentials that
  can create the resources in these labs
- An AWS account you are comfortable creating/destroying resources in (use a
  sandbox or dev account, never production)
- Basic familiarity with the AWS Console to verify what Terraform creates

> **Cost warning:** Several tasks create billable resources (EC2, NAT Gateway,
> S3, DynamoDB). Always run `terraform destroy` when you finish a lab to avoid
> charges. The VPC stack in Task 12 (NAT Gateway) is the most expensive — do
> not leave it running.

## The Core Workflow

Every task uses the same loop. Learn it once, repeat it everywhere:

```bash
terraform init      # download providers, set up backend
terraform fmt       # format code to canonical style
terraform validate  # check syntax and internal consistency
terraform plan      # preview what will change
terraform apply     # create/update resources
terraform destroy   # tear everything down
```

---

## Difficulty Legend

| Level | Meaning |
|---|---|
| 🟢 Easy | Core syntax and the basic workflow |
| 🟡 Medium | Real-world patterns: state, data sources, iteration, modules |
| 🔴 Complex | Composition, multi-env, dynamic config, full architectures |

---

## Tasks

### 🟢 Task 01 — Your First Resource
**Folder:** `task-01-first-resource`

Write the minimal Terraform configuration: a provider block and a single
resource (an S3 bucket). Run the full `init → plan → apply → destroy` loop.

**What it teaches:** the provider/resource model, HCL block syntax, how
Terraform maps config to real cloud resources, and the basic lifecycle. This is
the "hello world" of Terraform.

---

### 🟢 Task 02 — Variables, Outputs & Locals
**Folder:** `task-02-variables-outputs`

Parameterize the Task 01 bucket. Introduce input variables (with types,
defaults, and validation), `locals` for computed values, and `output` values to
expose attributes after apply. Pass values via `.tfvars` and the CLI.

**What it teaches:** how to make configurations reusable and configurable
instead of hardcoded. Variables, locals, outputs, and variable precedence are
the backbone of every real Terraform project.

---

### 🟢 Task 03 — Understanding State
**Folder:** `task-03-state-backend`

Explore the local `terraform.tfstate` file. Inspect it with `terraform state
list`, `terraform state show`, and `terraform show`. Practice `terraform import`
to bring an existing resource under management, and see what drift looks like by
changing a resource in the console.

**What it teaches:** what state is, why Terraform needs it, and how to inspect
and manipulate it safely. Understanding state is the single most important
concept for avoiding disasters later.

---

### 🟡 Task 04 — Multiple Resources & Dependencies
**Folder:** `task-04-multiple-resources`

Create several interrelated resources — a VPC, a subnet, a security group, and
an EC2 instance — where resources reference each other's attributes. Observe how
Terraform builds the dependency graph and orders operations automatically.

**What it teaches:** implicit vs. explicit dependencies (`depends_on`), resource
attribute references, and how Terraform's graph determines create/destroy order.

---

### 🟡 Task 05 — Data Sources
**Folder:** `task-05-data-sources`

Use `data` blocks to query existing infrastructure instead of hardcoding values:
look up the latest Amazon Linux AMI, the current AWS account ID, available
availability zones, and a default VPC.

**What it teaches:** how to read existing/external data into your config, keeping
it dynamic and portable across regions and accounts rather than relying on
magic strings.

---

### 🟡 Task 06 — Iteration with count & for_each
**Folder:** `task-06-count-foreach`

Create multiple similar resources without copy-paste. Use `count` for numbered
duplicates and `for_each` for keyed collections (maps/sets). Compare the two and
learn when each is appropriate, plus `for` expressions for transforming data.

**What it teaches:** DRY infrastructure. `for_each` vs `count` is a classic
interview topic and a frequent source of real-world bugs — understanding the
difference matters.

---

### 🟡 Task 07 — Modules
**Folder:** `task-07-modules`

Refactor repeated configuration into a reusable local module (e.g., a
"web-server" module), then call it multiple times with different inputs. Wire up
module inputs and outputs.

**What it teaches:** composition and reuse — the key to scaling Terraform across
teams and environments. Modules are how every serious Terraform codebase is
organized.

---

### 🟡 Task 08 — Remote State with S3 & DynamoDB
**Folder:** `task-08-remote-state`

Migrate state from local to a remote **S3 backend** with **DynamoDB state
locking**. Create the backend resources first, then configure the `backend "s3"`
block and migrate. Simulate a teammate to show how locking prevents concurrent
applies.

**What it teaches:** how teams share state safely. Remote state with locking is
mandatory for any collaborative or CI/CD-driven Terraform workflow.

---

### 🟡 Task 09 — Workspaces & Multi-Environment
**Folder:** `task-09-workspaces`

Use `terraform workspace` to manage dev/staging/prod from a single config, and
contrast it with the directory-per-environment pattern. Use
`terraform.workspace` to vary resource names and sizes per environment.

**What it teaches:** strategies for managing multiple environments, the trade-offs
of workspaces vs. separate state files, and how to avoid cross-environment
mistakes.

---

### 🔴 Task 10 — Provisioners & Lifecycle Rules
**Folder:** `task-10-provisioners-lifecycle`

Explore the escape hatches: `provisioner` blocks (`remote-exec`, `local-exec`),
`null_resource` with triggers, and `lifecycle` meta-arguments
(`create_before_destroy`, `prevent_destroy`, `ignore_changes`).

**What it teaches:** when (and when *not*) to use provisioners, and how lifecycle
rules let you control Terraform's default create/destroy behavior for
zero-downtime changes and protecting critical resources.

---

### 🔴 Task 11 — Dynamic Blocks & Advanced Expressions
**Folder:** `task-11-dynamic-blocks`

Generate nested configuration blocks programmatically with `dynamic` blocks (e.g.
security group rules from a variable list). Combine with `for` expressions,
conditional (`? :`) expressions, `try()`, and functions like `merge()`,
`lookup()`, and `flatten()`.

**What it teaches:** advanced HCL for building flexible, data-driven
configurations. Dynamic blocks are essential for writing clean, reusable modules.

---

### 🔴 Task 12 — Full VPC + Application Stack (Capstone)
**Folder:** `task-12-full-vpc-stack`

Combine everything into a production-style architecture built from your own
modules:

- A VPC with public and private subnets across multiple AZs
- Internet Gateway, NAT Gateway, and route tables
- An Application Load Balancer in the public subnets
- An Auto Scaling Group of EC2 instances in the private subnets
- Security groups wired together with least-privilege rules
- Remote state backend, variables per environment, and clean outputs

**What it teaches:** how all the pieces fit together into a real,
multi-tier deployment. This is the closest to what you will build on the job and
ties together modules, iteration, data sources, remote state, and dynamic blocks.

---

## Suggested Study Path

1. Do Tasks 01–03 in one sitting to internalize the core workflow and state.
2. Tasks 04–07 teach the day-to-day patterns you will use constantly.
3. Tasks 08–09 cover team/production practices.
4. Tasks 10–12 are advanced; take your time and verify each resource in the
   AWS Console.

After each task: run `terraform destroy`, then write down in your own words what
the task taught you. Teaching it back is the fastest way to retain it.

## Concept Coverage Map

| Concept | Covered In |
|---|---|
| Providers & resources | 01 |
| Variables, locals, outputs | 02 |
| State inspection & import | 03 |
| Dependencies & the resource graph | 04 |
| Data sources | 05 |
| `count` / `for_each` / `for` | 06 |
| Modules | 07, 12 |
| Remote state & locking | 08, 12 |
| Workspaces & multi-env | 09 |
| Provisioners & lifecycle | 10 |
| Dynamic blocks & functions | 11, 12 |
| Full architecture composition | 12 |

---

Happy building. Remember: **`plan` before every `apply`, and `destroy` when
you're done.**
