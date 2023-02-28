variable "env" {
  type    = string
  default = "alpha"
}

variable "lambda_name" {
  type    = string
  default = "lambda"

}

variable "lambda_path" {
  type    = string
  default = "/"

}

variable "lambda_filename" {
  type    = string
  default = "lambda"

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

variable "schedule_expression" {
  type    = string
  default = "cron(0 0 ? * MON-FRI *)"

}
