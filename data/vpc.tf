provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "this" {
  default = false
  tags = {
    Name = "tf+vpc"
  }

  lifecycle {
    postcondition {
      condition     = self.tags["Name"] == "tf+vpc"
      error_message = "VPC not found"
    }
  }
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
