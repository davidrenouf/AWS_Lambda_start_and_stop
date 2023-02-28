module "lambda_stop" {
  source = "./modules/lambda"

  env                 = "stop"
  lambda_name         = "stop_environement"
  lambda_path         = "./lambda"
  lambda_description  = "Stop"
  lambda_filename     = "stop_environement"
  runtime             = "python3.9"
  compatible_runtimes = ["python3.9"]
}

module "lambda_start" {
  source = "./modules/lambda"

  env                 = "start"
  lambda_name         = "start_environement"
  lambda_path         = "./lambda"
  lambda_description  = "Start"
  lambda_filename     = "start_environement"
  runtime             = "python3.9"
  compatible_runtimes = ["python3.9"]
}
