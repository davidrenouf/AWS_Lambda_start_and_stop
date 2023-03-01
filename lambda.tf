module "lambda_sands" {
  source = "./modules/lambda"

  env                       = "dev"
  lambda_prefix_name        = "lambda_sands"
  lambda_description        = "SandS"
  schedule_expression_start = "cron(0 21 ? * MON-FRI *)"
  schedule_expression_stop  = "cron(0 8 ? * MON-FRI *)"
  #instanceName              = "lambda-test,toto"
  #asgName                   = "test-lambda,test-lambda-2"
  #dbClusterId               = "database-1,database-2"
}
