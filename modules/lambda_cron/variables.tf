variable "region" {
  description = "Region in which to create the bucket"
  type        = string
}

variable "env" {
  description = "Environment name to which the bucket will be linked"
  type        = string
}

variable "lambda_source_file" {
  type = string
}

variable "lambda_archive_path" {
  description = "Lambda generated ZIP archive path"
  type        = string
}

variable "lambda_function_name" {
  type = string
}

variable "lambda_handler" {
  description = "Handler function name"
  type        = string
}

variable "lambda_description" {
  type = string
}

variable "lambda_runtime" {
  type    = string
  default = "python3.8"
}

variable "lambda_timeout" {
  type    = number
  default = 180
}

variable "lambda_iam_policy_description" {
  type = string
}

variable "lambda_iam_actions" {
  type    = list(string)
  default = []
}

variable "cloudwatch_rule_schedule_expression" {
  description = "Must be like: cron(Minutes Hours Day-of-month Month Day-of-week Year)"
  type        = string
}

variable "is_cloudwatch_rule_enabled" {
  type    = bool
  default = true
}

variable "cloudwatch_event_target_input" {
  type    = map(string)
  default = {}
}

variable "cloudwatch_log_group_kms_key_arn" {
  type = string
}

variable "lambda_layers" {
  type    = list(string)
  default = []
}
