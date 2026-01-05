data "aws_vpc" "this" {
  default = (var.vpc_name == "")
  tags    = var.vpc_name != "" ? { Name = var.vpc_name } : {}
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }

  filter {
    name   = "map-public-ip-on-launch"
    values = [true]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }

  filter {
    name   = "map-public-ip-on-launch"
    values = [false]
  }
}
