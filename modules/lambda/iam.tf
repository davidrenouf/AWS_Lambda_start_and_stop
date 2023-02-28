############################
# IAM Lambda role & policy #
############################

resource "aws_iam_role" "role" {
  name               = "${var.lambda_name}-role"
  path               = "/"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda-policy"
  role = aws_iam_role.role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "ec2:DescribeInstances",
            "ec2:StartInstances",
            "ec2:StopInstances",
            "rds:DescribeDBClusters",
            "rds:DescribeDBInstances",
            "rds:StartDBCluster",
            "rds:StopDBCluster",
            "autoscaling:DescribeAutoScalingGroups",
            "autoscaling:UpdateAutoScalingGroup",
            "autoscaling:SetDesiredCapacity"
        ],
        "Resource": "*"
    }
  ]
}
EOF
}
