output "bucket_arn" {
  description = "ARN of the created bucket"
  value = resource.aws_s3_bucket.bucket.arn 
}

output "bucket_id" {
  description = "ID of the created bucket"
  value = resource.aws_s3_bucket.bucket.id
}
