resource "aws_db_instance" "example" {
  identifier_prefix   = "tf-example-"
  engine              = "mysql"
  allocated_storage   = 5
  instance_class      = "db.t4g.micro"
  skip_final_snapshot = true
  db_name             = "example_database"
  username            = local.mysql_credentials["username"]
  password            = local.mysql_credentials["password"]
}

locals {
  mysql_credentials = yamldecode(module.data.devops_secrets)["mysql"]
}
