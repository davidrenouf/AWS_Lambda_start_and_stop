module "lambda_stop" {
  source = "./modules/lambda"

  env = "test"
  lambda_name = "stop_admin_instances"
  lambda_path = "./lambda"
  lambda_description = "Stop"
  lambda_filename = "stop_admin_instances"
  runtime = "python3.9"
  layer_description = "Layer"
  compatible_runtimes = ["python3.9"]
}

module "lambda_start" {
  source = "./modules/lambda"

  env = "test"
  lambda_name = "start_admin_instances"
  lambda_path = "./lambda"
  lambda_description = "Start"
  lambda_filename = "start_admin_instances"
  runtime = "python3.9"
  layer_description = "Layer"
  compatible_runtimes = ["python3.9"]
}

#######################
# EventBridge trigger #
#######################

# resource "aws_cloudwatch_event_rule" "notify_slack_rule" {
#   name                = "trigger-notify-slack"
#   description         = "Schedule lambda function to delete old unregister spot runners"
#   schedule_expression = "cron(0 8 ? * MON-FRI *)"
# }

# resource "aws_cloudwatch_event_target" "lambda_function_target_notify_slack" {
#   target_id = "lambda-notify-slack"
#   rule      = aws_cloudwatch_event_rule.notify_slack_rule.name
#   arn       = aws_lambda_function.notify_slack_lambda_function.arn
# }

# resource "aws_lambda_permission" "notify_slack_allow_cloudwatch" {
#   statement_id  = "AllowExecutionFromCloudWatch"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.notify_slack_lambda_function.function_name
#   principal     = "events.amazonaws.com"
#   source_arn    = aws_cloudwatch_event_rule.notify_slack_rule.arn
# }
