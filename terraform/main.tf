provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = "~> 5.0"
  }

  backend "s3" {
    bucket = "fiap-hackathon-terraform-ms"
    key    = "fiap-hackathon-ms-api-gateway"
    region = "us-east-1"
  }
}

module "eks" {
  source       = "./modules/eks"
  cluster_name = "fiap-hackathon-cluster"
}

module "api-gateway" {
  source              = "./modules/api-gateway"
  jwt_audience        = module.cognito.user_pool_client_id
  jwt_issuer          = module.cognito.user_pool_endpoint
  auth_lambda_arn     = module.lambda.auth_lambda_arn
  aws_subnet          = module.eks.aws_subnet
  eks_cluster         = module.eks.eks_cluster
  manager_ms_url      = var.manager_ms_url
  point_record_ms_url = var.point_record_ms_url
  reports_ms_url      = var.reports_ms_url
}

module "cognito" {
  source = "./modules/cognito"
}

module "ecr" {
  source = "./modules/ecr"
}

module "lambda" {
  source                   = "./modules/lambda"
  lambda_bucket_id         = module.s3.lambda_bucket_id
  apigateway_id            = module.api-gateway.apigateway_id
  apigateway_execution_arn = module.api-gateway.apigateway_execution_arn
  aws_subnet               = module.eks.aws_subnet
}

module "s3" {
  source = "./modules/s3"
}

module "rds" {
  source = "./modules/rds"
  db_username = var.db_username
  db_password = var.db_password
}