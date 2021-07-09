###CREATE TARGETS GROUP
resource "aws_lb_target_group" "lb_group" {
  name     = "http"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  health_check {
    interval = 15
    path = "/index.html"
  }
  vpc_id   = aws_vpc.lb_vpc.id
}