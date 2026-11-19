terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "n3rl-state-bucket"
    key = "task08/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "my-tf-locks"
    encrypt = true
  }
}
