provider "aws" {
  region = var.region

  default_tags {
    tags = {
      creator = "terraform"
    }
  }
}

resource "aws_instance" "example" {
  ami                    = module.data.ami_ubuntu_minimal_arm64
  instance_type          = "t4g.nano"
  subnet_id              = module.data.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name               = aws_key_pair.ec2_key.key_name

  user_data                   = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y apache2 busybox
    echo "Hello, World" > index.html
    nohup busybox httpd -f -p ${var.server_port} &
    EOF
  user_data_replace_on_change = true

  tags = {
    Name = "${module.data.env_or_user}-instance"
  }

  instance_market_options {
    market_type = "spot"
    spot_options {
      instance_interruption_behavior = "terminate"
    }
  }
}

resource "aws_security_group" "instance" {
  name   = "${module.data.env_or_user}-sg"
  vpc_id = module.data.vpc_id

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
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
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "${module.data.env_or_user}-instance-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
