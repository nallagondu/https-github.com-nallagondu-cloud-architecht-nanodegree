provider "aws" {
    shared_credentials_file = "/Users/d441303/.aws/credentials"
    profile = "personal"
    region = var.region
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "archive_file" "lambda_zip" {
    type        = "zip"
    source_dir  = "code"
    output_path = "lambda_payload.zip"
}

resource "aws_lambda_function" "greet_lambda"{
    filename = "lambda_payload.zip"
    source_code_hash = data.archive_file.lambda_zip.output_base64sha256
    function_name = "greet_lambda"
    handler = "greet_lambda.lambda_handler"
    role = aws_iam_role.iam_for_lambda.arn
    runtime = "python3.8"
    depends_on = [aws_iam_role_policy_attachment.lambda_logs]
    environment {
        variables = {
        greeting = "Hello"
        }
    }
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

