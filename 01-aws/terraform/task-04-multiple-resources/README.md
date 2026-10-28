# Task 04 — Multiple Resources & Dependencies 🟡

## Goal
Build interrelated resources and understand Terraform's dependency graph.

## What You'll Build
A VPC, a subnet, a security group, and an EC2 instance that reference each other.

## Steps
1. Create an `aws_vpc`.
2. Create an `aws_subnet` referencing `aws_vpc.this.id` (implicit dependency).
3. Create an `aws_security_group` in the VPC allowing SSH from your IP only.
4. Create an `aws_instance` in the subnet using the security group.
5. Add an `aws_internet_gateway` and use `depends_on` somewhere to see an
   explicit dependency.
6. Run `terraform plan` and read the order; run `terraform graph` to visualize it.

## Concepts
- Attribute references between resources
- Implicit vs explicit (`depends_on`) dependencies
- The resource dependency graph and operation ordering

## Success Criteria
- Resources create in the correct order automatically.
- `terraform graph` shows the dependency tree.

## Cleanup
```bash
terraform destroy
```
