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

resource "aws_s3_bucket" "my_backend_bucket" {
  bucket = "n3rl-state-bucket"
}

resource "aws_s3_bucket_versioning" "my_backend_bucket_versioning" {
  bucket = aws_s3_bucket.my_backend_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "my_backend_bucket_encryption" {
  bucket = aws_s3_bucket.my_backend_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


resource "aws_dynamodb_table" "my-tf-locks" {
  name = "my-tf-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
