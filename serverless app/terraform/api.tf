resource "aws_api_gateway_rest_api" "this" {
  name = local.namespaced_service_name

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
