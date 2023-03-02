module "lambda_sands" {
  source = "./modules/lambda"

  env                       = "dev"
  lambda_prefix_name        = "lambda_sands"
  lambda_description        = "SandS"
  schedule_expression_start = "cron(0 8 ? * MON-FRI *)"
  schedule_expression_stop  = "cron(0 21 ? * MON-FRI *)"
  #instanceName              = "myInstance1,myInstance2"
  #asgName                   = "myAsg1,myAsg2"
  #dbClusterId               = "dbCluster1,dbCluster2"
}
