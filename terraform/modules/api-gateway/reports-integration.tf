resource "aws_apigatewayv2_integration" "reports_ms" {
  api_id = aws_apigatewayv2_api.main.id
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  integration_uri    = "${var.reports_ms_url}/{proxy}"
  connection_type    = "INTERNET"
}

resource "aws_apigatewayv2_route" "reports_ms_route" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /reports/{proxy+}"
  target = "integrations/${aws_apigatewayv2_integration.reports_ms.id}"
  authorization_type = "JWT"
  authorizer_id = aws_apigatewayv2_authorizer.api_authorize.id
}