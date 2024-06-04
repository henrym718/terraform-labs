resource "aws_api_gateway_rest_api" "my_api" {
  name        = "my_api_gateway"  
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "my_resource" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  parent_id   = aws_api_gateway_rest_api.my_api.root_resource_id
  path_part   = "my_resource"
}

resource "aws_api_gateway_method" "my_method_get" {
  rest_api_id   = aws_api_gateway_rest_api.my_api.id
  resource_id   = aws_api_gateway_resource.my_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "my_integration" {
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  resource_id = aws_api_gateway_resource.my_resource.id
  http_method = aws_api_gateway_method.my_method_get.http_method

  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.my_function.invoke_arn

}

resource "aws_api_gateway_deployment" "my_deployment" {
  depends_on  = [aws_api_gateway_integration.my_integration]
  rest_api_id = aws_api_gateway_rest_api.my_api.id
  stage_name  = "prod"
}


/** 
rest_api_id identifica el API al que pertenece el recurso y parent_id especifica dónde se ubicará el recurso en la jerarquía de recursos dentro del API. Estas propiedades son necesarias para definir la ubicación y la asociación del recurso dentro de la estructura del API en AWS API Gate
**/