variable "resource_tags" {
  type    = map(string)
  default = {}
}

variable "region" {
  type        = string
  description = "The AWS region to deploy resource to"
}

variable "environment" {
  type        = string
  description = "e.g ControlPlane|Primary|Secondary|Sandbox"
}

variable "dynamodb_name" {
  type        = string
  description = "Name of the dynamo db for state locking"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of the bucket wheere state file will be kept"
}

variable "project" {
  type        = string
  description = "project name"
}

