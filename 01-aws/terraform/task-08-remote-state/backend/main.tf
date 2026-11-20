terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "n3rl-state-bucket"
    key = "task08/terraform.tfstate"
    use_lockfile = true
    region = "us-east-1"
    encrypt = true
  }
}
