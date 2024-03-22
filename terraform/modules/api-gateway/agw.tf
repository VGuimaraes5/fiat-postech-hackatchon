resource "aws_apigatewayv2_api" "main" {
  name          = "fiap-hackathont-api-gw"
  protocol_type = "HTTP"
  
  tags = {
    fiap = "hackathon",
  }
}

resource "aws_apigatewayv2_stage" "production" {
  api_id      = aws_apigatewayv2_api.main.id
  name        = "production"
  auto_deploy = true
  
  tags = {
    fiap = "hackathon",
  }

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

resource "aws_cloudwatch_log_group" "api_gw" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.main.name}"
  retention_in_days = 30
  
  tags = {
    fiap = "hackathon",
  }
}

resource "aws_apigatewayv2_authorizer" "api_authorize" {
  name             = "cognito_authorizer"
  api_id           = aws_apigatewayv2_api.main.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]

  jwt_configuration {
    audience = [var.jwt_audience]
    issuer   = "https://${var.jwt_issuer}"
  }
}

resource "aws_apigatewayv2_vpc_link" "eks" {
  name               = "eks"
  security_group_ids = [var.eks_cluster.vpc_config[0].cluster_security_group_id]
  subnet_ids = [
    var.aws_subnet.subnet_private_1a,
    var.aws_subnet.subnet_private_1b,
  ]
}
