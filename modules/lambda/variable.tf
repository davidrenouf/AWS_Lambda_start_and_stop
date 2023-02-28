variable "env" {
  type    = string
  default = "env1"
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
  default = "Description"

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
  default = "Description"

}

variable "compatible_runtimes" {
  type    = set(string)
  default = ["python3.9"]

}
