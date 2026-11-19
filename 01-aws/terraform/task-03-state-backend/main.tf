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

locals {
  common_tags = merge(var.bucket_tags, {
    ManagedBy = "terraform"
  })
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  region = var.bucket_region
  tags = local.common_tags
}
