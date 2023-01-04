data "archive_file" "lambda_function_archive_file" {
  type        = "zip"
  source_file = var.lambda_source_file
  output_path = var.lambda_archive_path
}

resource "aws_lambda_function" "lambda_function" {
  filename         = var.lambda_archive_path
  function_name    = var.lambda_function_name
  handler          = var.lambda_handler
  role             = aws_iam_role.lambda_role.arn
  description      = var.lambda_description
  source_code_hash = data.archive_file.lambda_function_archive_file.output_base64sha256
  runtime          = var.lambda_runtime
  timeout          = var.lambda_timeout
  layers           = var.lambda_layers
  tags = {
    Name = var.lambda_function_name
  }

  depends_on = [
    aws_cloudwatch_log_group.cloudwatch_log_group
  ]
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowExecutionFromCloudWatchEventRule"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cloudwatch_event_rule.arn
}
