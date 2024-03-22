resource "aws_apigatewayv2_integration" "manager_ms_public" {
  api_id = aws_apigatewayv2_api.main.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = "${var.manager_ms_url}/{proxy}"

  connection_type    = "INTERNET"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "manager_ms_public_route" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "POST /manager/{proxy+}"
  target = "integrations/${aws_apigatewayv2_integration.manager_ms_public.id}"
}


// PRIVATE ROUTES

resource "aws_apigatewayv2_integration" "manager_ms" {
  api_id = aws_apigatewayv2_api.main.id
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  integration_uri    = "${var.manager_ms_url}/{proxy}"
  connection_type    = "INTERNET"
}

resource "aws_apigatewayv2_route" "pedido_ms_private_route" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /manager/{proxy+}"
  target = "integrations/${aws_apigatewayv2_integration.manager_ms.id}"
  authorization_type = "JWT"
  authorizer_id = aws_apigatewayv2_authorizer.api_authorize.id
}


