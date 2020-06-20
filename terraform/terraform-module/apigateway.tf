resource "aws_api_gateway_rest_api" "hello-api" {
  name        = "${var.project_slug}-${var.env}-api"
  description = "${var.project_slug}-${var.env} API"
  body        = data.template_file.configjson.rendered
  tags        = local.common_tags
}

resource "aws_api_gateway_deployment" "api-hello-v1" {
  rest_api_id = aws_api_gateway_rest_api.hello-api.id
}

data "template_file" "configjson" {
  template = file("${path.module}/../../api-spec/output.json")

  vars = {
    title       = "${var.project_slug}-${var.env}-api"
    description = "${var.project_slug}-${var.env} API"
    uri_arn     = aws_lambda_function.hello_lambda.invoke_arn
    role_arn    = aws_iam_role.hello_lambda_assume_role.arn
  }
}

resource "aws_api_gateway_stage" "api_stage" {
  stage_name    = "v1"
  rest_api_id   = aws_api_gateway_rest_api.hello-api.id
  deployment_id = aws_api_gateway_deployment.api-hello-v1.id
  tags          = local.common_tags
}
