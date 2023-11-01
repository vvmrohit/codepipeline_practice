data "aws_iam_policy_document" "tf-cicd-pipeline-policies"{
    statement {
      sid = ""
      actions = ["codestar-connections:UseConnection"]
      resources = ["*"]
      effect = "Allow"
    }
    statement {
      sid = ""
      actions = ["cloudwatch:*","s3:*", "codebuild:*"]
      resources = ["*"]
      effect = "Allow"
    }
}

data "aws_iam_policy_document" "tf-codebuild-policies"{
    statement {
      sid = ""
      actions = ["logs:*","s3:*","codebuild:*","secretsmanager:*","iam:*"]
      resources = ["*"]
      effect = "Allow"
    }
}