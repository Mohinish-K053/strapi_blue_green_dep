output "alb_dns_name" {
  value = aws_lb.strapi_alb.dns_name
}

output "ecs_service_name" {
  value = aws_ecs_service.strapi_service.name
}

output "codedeploy_app_name" {
  value = aws_codedeploy_app.strapi.name
}
