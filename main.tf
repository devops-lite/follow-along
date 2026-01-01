provider "aws" {
  region = var.region
}

resource "aws_instance" "example" {
  ami                    = data.aws_ami.ubuntu_minimal_arm64.id
  instance_type          = "t4g.nano"
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name               = aws_key_pair.ec2_key.key_name

  user_data                   = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y apache2 busybox
    echo "Hello, World" > index.html
    nohup busybox httpd -f -p 8080 &
    EOF
  user_data_replace_on_change = true

  tags = {
    Name    = "tf+example"
    creator = "terraform"
  }

  instance_market_options {
    market_type = "spot"
    spot_options {
      instance_interruption_behavior = "terminate"
    }
  }
}

resource "aws_security_group" "instance" {
  name   = "tf+example-instance"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress { # enable SSH for debugging
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    creator = "terraform"
  }
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "tf+ec2-key"
  public_key = file("~/.ssh/id_rsa.pub")

  tags = {
    creator = "terraform"
  }
}

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
