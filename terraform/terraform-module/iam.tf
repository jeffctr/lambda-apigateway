# Permissions for Hello  Lambda function

data "aws_iam_policy_document" "hello_lambda_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
        "apigateway.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "hello_lambda_permission_policy" {
  statement {
    sid    = "1"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      "arn:aws:logs:*"
    ]
  }

  statement {
    sid    = "5"
    effect = "Allow"
    actions = [
      "lambda:InvokeAsync",
      "lambda:InvokeFunction",
    ]

    resources = [
      aws_lambda_function.hello_lambda.arn,
    ]
  }
}

resource "aws_iam_role" "hello_lambda_assume_role" {
  name               = "${var.project_slug}-${var.env}-hello-lambda-role"
  tags               = local.common_tags
  assume_role_policy = data.aws_iam_policy_document.hello_lambda_role_policy.json
}

resource "aws_iam_policy" "hello_lambda_policy" {
  name   = "${var.project_slug}-${var.env}-hello-lambda-policy"
  policy = data.aws_iam_policy_document.hello_lambda_permission_policy.json
}

resource "aws_iam_role_policy_attachment" "hello_lambda_policy_attachment" {
  role       = aws_iam_role.hello_lambda_assume_role.name
  policy_arn = aws_iam_policy.hello_lambda_policy.arn
}

# Permissions for API Gateway  to invoke  Hello  lambda function

resource "aws_lambda_permission" "apigw_hello_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hello_lambda.arn
  principal     = "apigateway.amazonaws.com"
}
