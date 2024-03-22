resource "aws_apigatewayv2_integration" "auth_lambda" {
  api_id             = aws_apigatewayv2_api.main.id
  integration_uri    = var.auth_lambda_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "auth_route" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "POST /auth"
  target = "integrations/${aws_apigatewayv2_integration.auth_lambda.id}"
}