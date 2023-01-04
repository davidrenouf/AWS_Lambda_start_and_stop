###############################################################################
# 
###############################################################################
module "start_admin_instances_lambda_cron" {
  source = "./modules/lambda_cron"

  region = var.region
  env    = var.env

  lambda_source_file            = "lambda/start_admin_instances.py"
  lambda_archive_path           = "lambda/start_admin_instances.zip"
  lambda_function_name          = "${var.env}-start-admin-instances"
  lambda_handler                = "start_admin_instances.lambda_handler"
  lambda_description            = "Start admin instances"
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

  cloudwatch_rule_schedule_expression = "cron(20 16 ? * MON-FRI *)"
  cloudwatch_event_target_input = {
    "region" : var.region,
    "env" : var.env,
  }
  cloudwatch_log_group_kms_key_arn = aws_kms_key.kms_log_group_key.arn
}

###############################################################################
# 
###############################################################################

module "stop_admin_instances_lambda_cron" {
  source = "./modules/lambda_cron"

  region = var.region
  env    = var.env

  lambda_source_file            = "lambda/stop_admin_instances.py"
  lambda_archive_path           = "lambda/stop_admin_instances.zip"
  lambda_function_name          = "${var.env}-stop-admin-instances"
  lambda_handler                = "stop_admin_instances.lambda_handler"
  lambda_description            = "Stop admin instances"
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


  cloudwatch_rule_schedule_expression = "cron(10 16 ? * MON-FRI *)"
  cloudwatch_event_target_input = {
    "region" : var.region,
    "env" : var.env,
  }
  cloudwatch_log_group_kms_key_arn = aws_kms_key.kms_log_group_key.arn
}

resource "aws_kms_key" "kms_log_group_key" {
  description             = "KMS key for log groups encryption"
  deletion_window_in_days = 10
  policy = data.aws_iam_policy_document.kms_policy_key.json
}

resource "aws_kms_alias" "kms_alias_key" {
  name          = "alias/log-group_key"
  target_key_id = aws_kms_key.kms_log_group_key.id
}

data "aws_iam_policy_document" "kms_policy_key" {
  policy_id = "Key-policy-document"

  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current_account.account_id}:root",
      ]
    }

    actions = [
      "kms:*",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid    = "Allow use of the key"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["logs.${var.region}.amazonaws.com"]
    }

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]

    resources = [
      "*",
    ]
  }
}

data "aws_caller_identity" "current_account" {}