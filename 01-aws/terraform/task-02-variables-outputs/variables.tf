variable "bucket_name" {
  type = string
  description = "name of bucket"

  validation {
    condition = length(var.bucket_name) > 4 && substr(var.bucket_name, 0, 4) == "neil"
    error_message = "The bucket name must be longer than 4 and start with neil."
  }
}

variable "bucket_region" {
  type = string
  default = "us-east-1"
}

variable "bucket_tags" {
  type = map(string)
  default = {}
}
