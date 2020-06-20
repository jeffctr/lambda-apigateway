# Hello Lambda...

data "archive_file" "hello_lambda_deployment_package" {
  source_dir  = var.hello_lambda_filepath
  output_path = "hello-${var.deployment_package_name}"
  type        = "zip"
}

resource "aws_lambda_function" "hello_lambda" {
  function_name = "${var.project_slug}-${var.env}-hello"
  description   = "Commit ${data.external.git_details.result.commit} ${data.external.git_details.result.tag}"
  tags          = local.common_tags
  handler       = "main.handler"
  role          = aws_iam_role.hello_lambda_assume_role.arn
  runtime       = "python3.7"
  timeout       = var.lambda_timeout
  memory_size   = 832

  filename         = "hello-${var.deployment_package_name}"
  source_code_hash = data.archive_file.hello_lambda_deployment_package.output_base64sha256

  environment {
    variables = local.lambda_env
  }
}

resource "aws_lambda_function_event_invoke_config" "hello_invoke_config" {
  function_name          = aws_lambda_function.hello_lambda.function_name
  maximum_retry_attempts = 1
}

# General locals for these lambdas

locals {
  lambda_env = {
    GIT_COMMIT               = data.external.git_details.result.commit
    GIT_TAG                  = data.external.git_details.result.tag
    DEBUG_MODE               = "deactive"
    PYTHONPATH               = "/opt/site-packages"
  }
}
