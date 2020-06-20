provider "aws" {
  region  = "ap-southeast-2"
  version = ">= 2.4.0"
}

# Bucket where you are going to archive the deployment
terraform {
  backend "s3" {
    key    = "lambda-apigateway-hello/dev.tfstate"
    bucket = "" # You need to add the bucket name where you want to deploy your code
    region = "ap-southeast-2"
  }
}

module "deployment" {
  source   = "../terraform-module"
  env      = "dev"
  reseller = "Tutorial Example"

  # For use in resource tagging
  environment = "Development"
}

