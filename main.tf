resource "aws_instance" "example" {
  ami           = "ami-003954d35a6a87b23" // ubuntu 24.04, arm64, us-west-2
  region        = "us-west-2"
  instance_type = "t4g.nano"

  tags = {
    Name = "terraform-example"
  }

  instance_market_options {
    market_type = "spot"
    spot_options {
      instance_interruption_behavior = "terminate"
    }
  }
}
