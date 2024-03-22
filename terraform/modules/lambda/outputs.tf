output "auth_lambda_arn" {
  value = aws_lambda_function.auth_lambda.invoke_arn
}