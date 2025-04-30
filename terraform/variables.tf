variable "aws_region" {
  default = "us-east-1"
}

variable "app_name" {
  default = "strapi"
}

variable "container_port" {
  default = 1337
}

variable "ecr_image_uri" {
  description = "ECR image URI for the Docker image"
  type        = string
}


