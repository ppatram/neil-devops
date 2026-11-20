# Cronus Architecture

Audience: engineers working through the Terraform labs. Diagram: `cronus-architecture.drawio`. Criticality tier is assumed to be 2 (multi-AZ, single region). Change it if Cronus has a real tier.

## Flow
1. Users reach CloudFront (WAF attached) over HTTPS. Workforce auth is PingFederate / Global Auth.
2. `/` serves the SPA from a private S3 bucket through Origin Access Control.
3. `/app/*` goes to an ALB in the public subnets, then to an EC2 Auto Scaling group in the private subnets.
4. `/api/*` goes to API Gateway, then to a Lambda function.
5. Lambda writes to DynamoDB and publishes events to an SNS topic. SNS fans out to an SQS queue.
6. EC2 workers poll SQS and read/write DynamoDB through VPC endpoints. Failed messages go to a DLQ.

## Monitoring (every component has an alarm)
| Component | Alarms |
|---|---|
| CloudFront | 5xx rate, origin latency |
| S3 | 4xx, 5xx |
| ALB | 5xx, target latency, unhealthy hosts |
| EC2 ASG | CPU, status check failures |
| API Gateway | 4xx, 5xx, p99 latency |
| Lambda | errors, throttles, p99 duration |
| SNS | failed deliveries |
| SQS | oldest message age |
| DLQ | messages visible > 0 |
| DynamoDB | throttled requests, system errors |

All alarms publish to `cronus-ops-alerts` (SNS), which notifies email/Teams. Supporting pieces: CloudWatch logs and dashboard, X-Ray/ADOT tracing, a CloudWatch Synthetics canary on `/health`, CloudTrail, and Dynatrace (OneAgent on EC2, Lambda layer).

## Terraform lab mapping
| Lab | Where it shows up |
|---|---|
| 01-02 | S3 bucket, variables, outputs |
| 03, 08 | Remote state in S3 with DynamoDB locking |
| 04-05 | VPC, subnets, SGs, EC2; AMI and AZ data sources |
| 06 | `for_each` for alarms, subnets, queues |
| 07 | Modules: network, web, api, messaging, monitoring |
| 09 | Workspaces for dev/staging/prod |
| 10 | `lifecycle` on ASG launch template; `prevent_destroy` on DynamoDB |
| 11 | `dynamic` blocks for SG rules and alarm sets |
| 12 | Capstone: VPC, ALB, ASG |

## Assumptions
- Raw Terraform resources are used. The Delta CDK constructs (`DeltaDynamoDb` etc.) apply only to CDK.
- Encryption uses KMS on S3, DynamoDB, SQS, SNS and logs. Secrets are in Secrets Manager.
- Layout is not rendered-checked (draw.io CLI is not installed here). Open it in draw.io and adjust edge routing if needed.
