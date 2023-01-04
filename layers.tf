locals {
  layer_name_start_and_stop = "${var.env}-layer-start-and-stop"
  layer_path_start_and_stop = "${path.module}/layers/start-and-stop"
}

data "archive_file" "layer_start_and_stop" {
  type        = "zip"
  source_dir  = "${local.layer_path_start_and_stop}/"
  output_path = "${local.layer_path_start_and_stop}.zip"
}

resource "aws_lambda_layer_version" "layer_start_and_stop" {
  filename            = data.archive_file.layer_start_and_stop.output_path
  layer_name          = local.layer_name_start_and_stop
  description         = "Layer containing common functions for start and stop lambda"
  compatible_runtimes = ["python3.8"]
  source_code_hash    = filebase64sha256(data.archive_file.layer_start_and_stop.output_path)
}
