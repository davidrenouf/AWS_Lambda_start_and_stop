variable "env" {
  type    = string
  default = "env"
}

variable "lambda_prefix_name" {
  type    = string
  default = "prefix"

}

variable "lambda_description" {
  type    = string
  default = "This is a lambda"

}

variable "runtime" {
  type    = string
  default = "python3.9"
}

variable "layer_name" {
  type    = string
  default = "start_and_stop"

}

variable "layer_path" {
  type    = string
  default = "/"

}

variable "layer_description" {
  type    = string
  default = "Layer use to manage resources (EC2 Instances, EC2 Auto-Scaling Groups and AWS RDS)"

}

variable "compatible_runtimes" {
  type    = set(string)
  default = ["python3.9"]

}

variable "schedule_expression_start" {
  type     = string
  default  = "cron(0 1 ? * MON-FRI *)"

}

variable "schedule_expression_stop" {
  type     = string
  default  = "cron(0 0 ? * MON-FRI *)"

}

variable "instanceName" {
  type    = string
  default = "null"

}

variable "asgName" {
  type    = string
  default = "null"

}

variable "dbClusterId" {
  type    = string
  default = "null"

}
