###############################################################################
# 
###############################################################################
module "start_admin_instances_lambda_cron" {
  source = "../terraform-modules/lambda_cron"

  region = var.region
  env    = var.env

  lambda_source_file            = "lambda/start_admin_instances.py"
  lambda_archive_path           = "lambda/start_admin_instances.zip"
  lambda_function_name          = "${var.env}-start-admin-instances"
  lambda_handler                = "start_admin_instances.lambda_handler"
  lambda_description            = "Start admin instances in the morning during the week"
  lambda_timeout                = 900
  lambda_iam_policy_description = "Start environement lambda policy"
  lambda_iam_actions = [
    "logs:CreateLogStream",
    "logs:PutLogEvents",
    "ec2:DescribeInstances",
    "ec2:DescribeVpcs",
    "ec2:StartInstances",
    "rds:DescribeDBClusters",
    "rds:DescribeDBInstances",
    "rds:StartDBCluster",
    "autoscaling:DescribeAutoScalingGroups",
    "autoscaling:UpdateAutoScalingGroup",
    "autoscaling:SetDesiredCapacity",
    "eks:ListNodegroups",
    "eks:DescribeNodegroup",
  ]
  lambda_layers = [aws_lambda_layer_version.layer_start_and_stop.arn]

  cloudwatch_rule_schedule_expression = "cron(0 5 ? * MON-FRI *)"
  cloudwatch_event_target_input = {
    "region" : var.region,
    "env" : var.env,
    "db_cluster_identifier" : aws_rds_cluster.devfactory_aurora_cluster.id
  }
  cloudwatch_log_group_kms_key_arn = module.cloudwatch_kms_key.kms_key_arn
}

###############################################################################
# 
###############################################################################

module "stop_admin_instances_lambda_cron" {
  source = "../terraform-modules/lambda_cron"

  region = var.region
  env    = var.env

  lambda_source_file            = "lambda/stop_admin_instances.py"
  lambda_archive_path           = "lambda/stop_admin_instances.zip"
  lambda_function_name          = "${var.env}-stop-admin-instances"
  lambda_handler                = "stop_admin_instances.lambda_handler"
  lambda_description            = "Stop admin instances at night and during the weekend"
  lambda_timeout                = 900
  lambda_iam_policy_description = "Stop environement lambda policy"
  lambda_iam_actions = [
    "logs:CreateLogStream",
    "logs:PutLogEvents",
    "ec2:DescribeInstances",
    "ec2:StopInstances",
    "rds:DescribeDBClusters",
    "rds:DescribeDBInstances",
    "rds:StopDBCluster",
    "autoscaling:DescribeAutoScalingGroups",
    "autoscaling:UpdateAutoScalingGroup",
    "autoscaling:SetDesiredCapacity",
    "eks:ListNodegroups",
    "eks:DescribeNodegroup",
  ]
  lambda_layers = [aws_lambda_layer_version.layer_start_and_stop.arn]


  cloudwatch_rule_schedule_expression = "cron(5 22 ? * MON-FRI *)"
  cloudwatch_event_target_input = {
    "region" : var.region,
    "env" : var.env,
    "db_cluster_identifier" : aws_rds_cluster.devfactory_aurora_cluster.id
  }
  cloudwatch_log_group_kms_key_arn = module.cloudwatch_kms_key.kms_key_arn
}
