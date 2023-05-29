resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  subnets = [aws_subnet.my_public_subnet.id, aws_subnet.my_public_subnet2.id]
  security_groups = [aws_security_group.my_security_group.id]
  # enable_deletion_protection = true

  tags = {
    Environment = "docker-test"
  }
}

resource "aws_lb_target_group" "alb_tg" {
  name     = "myalbtg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = 200
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 3
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "alb_tga1" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.my_web_server.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "alb_tga2" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.my_web_server2.id
  port             = 80
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  protocol          = "HTTP"
  port              = 80
  default_action {
    target_group_arn = aws_lb_target_group.alb_tg.arn
    type             = "forward"
  }
}