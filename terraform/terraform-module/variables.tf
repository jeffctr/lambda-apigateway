data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

variable "project_slug" {
  default = "tutorial-hello-validator"
}

# For use in resource tagging
variable "environment" {}
variable "reseller" {}
variable "project" {
  default = "Lambda API GateWays hello validator"
}

variable "env" {}

variable "python_version" {
  default = "3.7"
}

variable "hello_lambda_filepath" {
  default = "../../lambda/hello"
}

variable "deployment_package_name" {
  default = "lambda.zip"
}

variable "lambda_timeout" {
  default = "30"
}

data "external" "git_details" {
  program = ["bash", "../version.sh"]
}

locals {
  common_tags = {
    Project     = var.project
    Reseller    = var.reseller
    Environment = var.environment
  }
}
