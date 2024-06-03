
data "aws_iam_policy_document" "assume_role" {
    statement {
        effect = "Allow"

        principals {
            type       = "Service"
            identifiers = ["lambda.amazonaws.com"]
        }

        actions = ["sts:AssumeRole"]
    }
}

resource "aws_iam_role" "iam_for_lambda" {
    name               = "iam_for_lambda"
    assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda_zip" {
    type        = "zip"
    source_dir  = "../package/"
    output_path = "lambda.zip"
}

resource "aws_lambda_function" "demo_lambda" {
    filename = "lambda.zip"
    function_name = "lambda_function_demo"
    role = aws_iam_role.iam_for_lambda.arn
    handler = "main.lambda_handler"

    source_code_hash = data.archive_file.lambda_zip.output_base64sha256

    runtime = "python3.9"
}