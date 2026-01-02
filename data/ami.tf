data "aws_ami" "ubuntu_minimal_arm64" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["*/ubuntu-noble-24.*-arm64-minimal-*"]
  }
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
}
