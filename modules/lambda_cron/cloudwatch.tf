resource "aws_cloudwatch_event_rule" "cloudwatch_event_rule" {
  name                = var.lambda_function_name
  description         = var.lambda_description
  schedule_expression = var.cloudwatch_rule_schedule_expression
  is_enabled          = var.is_cloudwatch_rule_enabled
}

resource "aws_cloudwatch_event_target" "cloudwatch_event_target" {
  target_id = var.lambda_function_name
  arn       = aws_lambda_function.lambda_function.arn
  rule      = aws_cloudwatch_event_rule.cloudwatch_event_rule.name

  input = <<EOF
  ${jsonencode(var.cloudwatch_event_target_input)}
EOF

}

resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 14
  kms_key_id        = var.cloudwatch_log_group_kms_key_arn

}
