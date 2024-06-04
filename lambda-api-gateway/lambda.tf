resource "aws_lambda_function" "my_function" {
  function_name = "my_lambda"
  runtime       = "nodejs20.x"
  role          = "arn:aws:iam::922425102602:role/Lambda_S3FullAccess"
  s3_bucket     = "picturespublicas"
  s3_key        = "lambda_funcion.zip"
  handler       = "index.handler"
}

resource "aws_lambda_permission" "allow_api_gateway" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/*"
}
