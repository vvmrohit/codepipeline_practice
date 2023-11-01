resource "aws_s3_bucket" "codepipeline_artifact" {
  bucket = "pipeline-artifact-terraform-learning"
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm     = "AES256"
      }
    }
  }
}