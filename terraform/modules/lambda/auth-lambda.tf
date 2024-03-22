resource "aws_lambda_function" "auth_lambda" {
  function_name = "AuthLambda"
  role = aws_iam_role.lambda_exec_role.arn

  s3_bucket = var.lambda_bucket_id
  s3_key    = aws_s3_object.auth_lambda.key

  runtime = "dotnet6"
  handler = "AuthLambda::AuthLambda.Function::FunctionHandler"
  timeout = 12
  source_code_hash = data.archive_file.auth_lambda.output_base64sha256

  tags = {
    fiap = "hackathon",
  }
}

data "archive_file" "auth_lambda" {
  type = "zip"
  source_dir  = "./lambda"
  output_path = "./auth_lambda.zip"
}

resource "aws_s3_object" "auth_lambda" {
  bucket = var.lambda_bucket_id
  key    = "auth_lambda.zip"
  source = data.archive_file.auth_lambda.output_path
  etag = filemd5(data.archive_file.auth_lambda.output_path)
}

resource "aws_lambda_permission" "api_gw_auth_lambda" {
  function_name = aws_lambda_function.auth_lambda.function_name
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn = "${var.apigateway_execution_arn}/*/*"
}