locals {
  lambdas = {
    start = "${var.schedule_expression_start}"
    stop  = "${var.schedule_expression_stop}"
  }
  lambda_prefix_name = "${var.env}_${var.lambda_prefix_name}"
  lambda_path        = "${path.module}/lambda"
}

data "archive_file" "python_lambda_package" {
  for_each    = tomap(local.lambdas)
  type        = "zip"
  source_file = "${local.lambda_path}/${each.key}_environement.py"
  output_path = "lambda_${local.lambda_prefix_name}_${each.key}.zip"
}

resource "aws_lambda_function" "lambda_function" {
  for_each         = tomap(local.lambdas)
  function_name    = "${local.lambda_prefix_name}_${each.key}"
  filename         = data.archive_file.python_lambda_package[each.key].output_path
  description      = "Lambda to manage environement lifecycle --> ${each.key}"
  runtime          = var.runtime
  source_code_hash = filebase64sha256(data.archive_file.python_lambda_package[each.key].output_path)
  role             = aws_iam_role.role.arn
  handler          = "${each.key}_environement.lambda_handler"
  layers           = [aws_lambda_layer_version.layer.arn]
  timeout          = 20
  environment {
    variables = {
      InstanceName = var.instanceName,
      AsgName      = var.asgName,
      DbClusterId  = var.dbClusterId
    }
  }
}

#######################
# EventBridge trigger #
#######################

resource "aws_cloudwatch_event_rule" "rule" {
  for_each            = tomap(local.lambdas)
  name                = "${each.key}_${local.lambda_prefix_name}_trigger"
  description         = "Schedule ${each.key}_${local.lambda_prefix_name}"
  schedule_expression = "${each.value}"
}

resource "aws_cloudwatch_event_target" "lambda_function_target" {
  for_each  = tomap(local.lambdas)
  target_id = "${each.key}_${local.lambda_prefix_name}_target"
  rule      = aws_cloudwatch_event_rule.rule[each.key].name
  arn       = aws_lambda_function.lambda_function[each.key].arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  for_each      = tomap(local.lambdas)
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function[each.key].function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.rule[each.key].arn
}
