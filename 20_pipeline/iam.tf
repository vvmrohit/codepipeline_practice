resource "aws_iam_role" "tf-codepipline-role" {
  name = "tf-codepipline-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "tf-cicd-pipeline-policy" {
  name = "tf-cicd-pipeline-policy"
  path = "/"
  description = "Pipeline policy"
  policy = data.aws_iam_policy_document.tf-cicd-pipeline-policies.json
}

resource "aws_iam_role_policy_attachment" "tf-cicd-pipeline-attachement1" {
  policy_arn = aws_iam_policy.tf-cicd-pipeline-policy.arn
  role = aws_iam_role.tf-pipeline-role.id
}


resource "aws_iam_role" "tf-codebuild-role" {
  name = "tf-codebuild-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_policy" "tf-codebuild-policy" {
  name = "tf-codebuild-policy"
  path = "/"
  description = "Codebuild policy"
  policy = data.aws_iam_policy_document.tf-codebuild-policies.json
}

resource "aws_iam_role_policy_attachment" "tf-codebuild-attachement1" {
  policy_arn = aws_iam_policy.tf-codebuild-policy
  role = aws_iam_role.tf-codebuild-role.id
}

resource "aws_iam_role_policy_attachment" "tf-codebuild-attachement2" {
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
  role = aws_iam_role.tf-codebuild-role.id
}