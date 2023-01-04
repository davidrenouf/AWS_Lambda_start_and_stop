resource "aws_iam_role" "lambda_role" {
  name               = "${var.lambda_function_name}-lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role_lambda_document.json
}

data "aws_iam_policy_document" "assume_role_lambda_document" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "lambda.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "${var.lambda_function_name}-lambda"
  description = var.lambda_iam_policy_description
  policy      = data.aws_iam_policy_document.lambda_document.json
}

data "aws_iam_policy_document" "lambda_document" {
  statement {
    actions = var.lambda_iam_actions

    effect = "Allow"

    resources = [
      "*",
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values = [
        var.region
      ]
    }
  }
}
