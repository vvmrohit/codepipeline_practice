output "backend" {
  value = <<EOF
        bucket = "${module.s3-bucket.s3_bucket_id}"
        key = ""
        encrypt = true
        region = "${var.region}"
        dynamodb_table = "${aws_dynamodb_table.tf_lock.name}"
    EOF
}