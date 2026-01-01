provider "aws" {
  region = var.region
}

resource "aws_security_group" "http" {
  name   = "allow_http"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
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

resource "aws_instance" "hello" {
  ami                    = data.aws_ami.al2023_arm64.id
  instance_type          = "t4g.nano"
  vpc_security_group_ids = [aws_security_group.http.id]
  subnet_id              = var.subnet_id

  user_data = <<-EOF
              #!/bin/bash
              yum install -y python3
              echo "Hello World" > index.html
              nohup python3 -m http.server 80 &
              EOF

  tags = {
    Name    = "hello-world"
    creator = "terraform"
  }
}

data "aws_ami" "al2023_arm64" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-arm64"]
  }
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
}

output "public_ip" {
  value = aws_instance.hello.public_ip
}
