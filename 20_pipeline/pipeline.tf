data "aws_ssm_parameter" "webhook_secret"{
  name = "/secrets/eit/webhook_secret"
}

module "pipeline" {
  # checkov:skip=CKV_TF_1: ADD REASON
  source = "git@github.com:vvmrohit/my_modules.git//aws-codepipeline"
  repository_owner = var.repository_owner
  repository_name = var.repository_name
  buildspec_ci = "pipelines/buildspec.feature.yml"
  buildspec_cd = "pipelines/buildspec.master.yml"
  build_image = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
  image_pull_credentials_type = "SERVICE_ROLE"
  project = var.project
  service = data.aws_caller_identity.current.account_id
  environment = var.environment
  github_token_ssm_path = "/Users/rohitpandey/rohit/authentications/github"
  codebuild_ci_iam_role = module.codebuild_iam_role.arn
  codebuild_cd_iam_role = module.codebuild_iam_role.arn
  enable_webhooks = true
  repository_branch = "main"
  region = var.region
  webhook_secret = data.aws_ssm_parameter.webhook_secret.value
}

module "codebuild_iam_role" {
  # checkov:skip=CKV_TF_1: ADD REASON
  source = "git@github.com:vvmrohit/my_modules.git//aws-iam-role"
  project = var.project
  service = var.project
  environment = var.environment
  assume_role_policy = data.aws_iam_policy_document.codebuild_trust_policy_document.json
  policy_document = data.aws_iam_policy_document.codebuild_policy_document.json
  service_principals = ["codebuild.amazonaws.com"]
  tags_override = module.tags.tags 
}

data "aws_iam_policy_document" "codebuild_trust_policy_document" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "codebuild.amazonaws.com"
      ]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "codebuild_policy_document" {
  # checkov:skip=CKV_AWS_111: ADD REASON
  # checkov:skip=CKV_AWS_108: ADD REASON
  # checkov:skip=CKV_AWS_49: ADD REASON
  # checkov:skip=CKV_AWS_107: ADD REASON
  # checkov:skip=CKV_AWS_109: ADD REASON
  # checkov:skip=CKV_AWS_1: ADD REASON
  # checkov:skip=CKV_AWS_110: We are restricting access through permisson boundry for all the account
  statement {
    effect = "Allow"

    actions = [
      "*"
    ]
    resources = ["*"]
  }
}