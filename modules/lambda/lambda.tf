locals {
  lambda_name = "${var.env}-${var.lambda_name}"
  lambda_path = var.lambda_path
}

data "archive_file" "python_lambda_package" {
  type        = "zip"
  source_file = "${local.lambda_path}/${var.lambda_filename}.py"
  output_path = "lambda_${var.lambda_name}.zip"
}

resource "aws_lambda_function" "lambda_function" {
  function_name    = local.lambda_name
  filename         = "${var.lambda_filename}.zip"
  description      = var.lambda_description
  runtime          = var.runtime
  source_code_hash = filebase64sha256(data.archive_file.python_lambda_package.output_path)
  role             = aws_iam_role.role.arn
  handler          = "${var.lambda_name}.lambda_handler"
  layers           = [aws_lambda_layer_version.layer.arn]
  timeout          = 20
}