locals {
  layer_name = "${var.layer_name}"
  layer_path = "${path.module}/layer/start_and_stop"
}

data "archive_file" "python_layer_package" {
  type        = "zip"
  source_dir  = "${local.layer_path}/"
  output_path = "layer_${local.layer_name}.zip"
}

resource "aws_lambda_layer_version" "layer" {
  layer_name          = local.layer_name
  filename            = data.archive_file.python_layer_package.output_path
  description         = var.layer_description
  compatible_runtimes = var.compatible_runtimes
  source_code_hash    = filebase64sha256(data.archive_file.python_layer_package.output_path)
}
