locals {
  name_prefix = "${lower(var.project)}-${data.aws_caller_identity.current.account_id}"
  dynamodb_tags = merge(
    var.resource_tags,
    {
      name        = "${var.dynamodb_name}",
      environment = "${var.environment}",
      creator     = "Terraform via ${var.project} 00_bootstrap",
      project     = "${var.project}"
    }
  )
  s3_bucket_tags = merge(
    var.resource_tags,
    {
      name        = "${var.s3_bucket_name}",
      environment = "${var.environment}",
      creator     = "Terraform via ${var.project} 00_bootstrap",
      project     = "${var.project}"
    }
  )
}