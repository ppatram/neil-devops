terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "bucket_count" {
  type = number
  default = 5
}

resource "random_uuid" "bucket_id" {
}

resource "aws_s3_bucket" "my_buckets" {
  bucket = "terraform-test-neilpatram-${random_uuid.bucket_id.result}"
  count = 4
}

resource "aws_iam_user" "users" {
  for_each = toset(["alice", "bob", "charlie"])
  name = each.key
}

variable "map_names" {
  type = map(string)
  default = {
    testbucket-lool01 = "tag1"
    testbucket-lol02 = "tag2"
    testbucket-lool03 = "tag3"
  }

}

resource "aws_s3_bucket" "key_buckets" {
  for_each = var.map_names
  bucket = each.key

  tags = {
    MadeUpTagValue = each.value
  }
}

output "buckets" {
  value = [for b in aws_s3_bucket.key_buckets: b.id]
}
