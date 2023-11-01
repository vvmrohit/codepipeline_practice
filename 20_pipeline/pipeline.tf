resource "aws_codebuild_project" "tf-plan" {
  name          = "tf-plan"
  description   = "Terraform Plan stage"
  service_role  = aws_iam_role.tf-codebuild-role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "hashicorp/terraform:1.4"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"
    registry_credential {
      credential = var.dockerhub_credentials
      credential_provider = "SECRETS_MANAGER"
    }
  }

  source {
    type = "CODEPIPELINE"
    buildspec = "pipelines/buildspec.feature.yml"
  }
}

resource "aws_codebuild_project" "tf-apply" {
  name          = "tf-apply"
  description   = "Terraform apply stage"
  service_role  = aws_iam_role.tf-codebuild-role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "hashicorp/terraform:1.4"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"
    registry_credential {
      credential = var.dockerhub_credentials
      credential_provider = "SECRETS_MANAGER"
    }
  }

  source {
    type = "CODEPIPELINE"
    buildspec = "pipelines/buildspec.master.yml"
  }
}

resource "aws_codepipeline" "cicd_pipeline" {
  name = "tf_pipeline"
  role_arn = aws_iam_role.tf-codepipline-role.arn
  artifact_store {
    type = s3
    location = aws_s3_bucket.codepipeline_artifact.id
  }
   encryption_key {
      id   = "${local.s3-kms.kms_key}"
      type = "KMS"
    }

}