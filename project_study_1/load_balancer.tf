resource "aws_lb_target_group" "tg" {
  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }
  name_prefix = "web-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.server_vpc.id
}

resource "aws_lb" "alb" {
  name               = "ALB-web"
  internal           = "false"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_public.id]
  subnets = [
    aws_subnet.public_subnet.id,
    aws_subnet.public_subnet_alb.id
  ]
  enable_deletion_protection = "false"

  tags = {
    name = "web_lb"
  }
}

resource "aws_lb_listener" "http_lis" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
