###CREATE LOAD BALLANCER
resource "aws_lb" "lb_main" {
  name               = "http-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sc.id]
  subnets            = [aws_subnet.lb_net_1.id, aws_subnet.lb_net_2.id]

  tags = {
    Environment = "LB_MAIN"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.lb_main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_group.arn
  }
}


output "lb_dns_name" {
  value = aws_lb.lb_main.dns_name
}