provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      creator = "terraform"
    }
  }
}

resource "aws_secretsmanager_secret" "devops" {
  name        = "devops"
  description = "devops secrets"
}

resource "aws_secretsmanager_secret_version" "devops" {
  secret_id     = aws_secretsmanager_secret.devops.id
  secret_string = file("${path.module}/.secrets.yml")
}
