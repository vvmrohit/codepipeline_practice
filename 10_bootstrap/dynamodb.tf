resource "aws_dynamodb_table" "tf_lock" {
  name         = "${local.name_prefix}--ddb-tf-lock"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
  server_side_encryption {
    enabled = false
  }


  tags = local.dynamodb_tags
}