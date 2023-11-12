data "aws_ssm_parameter" "github" {
 name = "/Users/rohitpandey/rohit/authentications/github" 
}

resource "aws_codebuild_project" "feature" {
  name = "${var.project}-pipeline-for-feature-branch"
  service_role = module.codebuild_iam_role.arn
  badge_enabled = true

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"
  }

  source {
    type = "GITHUB"
    location = "https://github.com/${var.repository_owner}/${var.repository_name}.git"
    buildspec = "pipelines/buildspec.feature.yml"
    report_build_status = true
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  tags = module.tags.tags
}

resource "aws_codebuild_source_credential" "feature" {
  auth_type = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token = data.aws_ssm_parameter.github.value
}

resource "aws_codebuild_webhook" "feature" {
  project_name = aws_codebuild_project.feature.name
  filter_group {
    filter {
      type = "EVENT"
      pattern = "PULL_REQUEST_CREATED, PULL_REQUEST_UPDATED, PULL_REQUEST_REOPENED"
    }

    filter {
      type = "HEAD_REF"
      pattern = "^(?!^/refs/heads/(master|main)$).*"
      exclude_matched_pattern = false
    }
  }
}
