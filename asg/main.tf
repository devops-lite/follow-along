provider "aws" {
  region = var.region
}

resource "aws_launch_template" "example" {
  name_prefix            = "tf.example-lt-"
  image_id               = module.data.ami_ubuntu_server_arm64
  instance_type          = "t4g.nano"
  vpc_security_group_ids = [aws_security_group.lt.id]

  instance_market_options {
    market_type = "spot"
    spot_options {
      spot_instance_type             = "one-time"
      instance_interruption_behavior = "terminate"
    }
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    echo "Hello, World" > index.html
    nohup busybox httpd -f -p ${var.server_port} &
    EOF
  )

  tag_specifications {
    resource_type = "spot-instances-request"
    tags = {
      creator = "terraform"
    }
  }

  tags = {
    creator = "terraform"
  }
}

resource "aws_security_group" "lt" {
  name   = "tf+example-lt"
  vpc_id = module.data.vpc_id

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
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

resource "aws_autoscaling_group" "example" {
  name_prefix = "tf.example-asg-"
  launch_template {
    id      = aws_launch_template.example.id
    version = aws_launch_template.example.latest_version
  }
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }
  min_size            = 2
  max_size            = 2
  vpc_zone_identifier = module.data.private_subnets
  target_group_arns   = [aws_lb_target_group.asg.arn]
  health_check_type   = "ELB"

  tag {
    key                 = "Name"
    value               = "tf+asg-example"
    propagate_at_launch = true
  }

  tag {
    key                 = "creator"
    value               = "terraform"
    propagate_at_launch = true
  }
}

resource "aws_alb" "example" {
  name               = "tf-asg-example"
  load_balancer_type = "application"
  subnets            = module.data.public_subnets
  security_groups    = [aws_security_group.alb.id]

  tags = {
    creator = "terraform"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_alb.example.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      status_code  = 404
      content_type = "text/plain"
      message_body = "Page not found"
    }
  }

  tags = {
    creator = "terraform"
  }
}

resource "aws_security_group" "alb" {
  name   = "tf+example-alb"
  vpc_id = module.data.vpc_id

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

resource "aws_lb_target_group" "asg" {
  name     = "tf-asg-example"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = module.data.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    creator = "terraform"
  }
}

resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }

  tags = {
    creator = "terraform"
  }
}
