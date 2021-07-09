###ATTACH INSTANCES
resource "aws_lb_target_group_attachment" "lb_inst_1" {
  target_group_arn = aws_lb_target_group.lb_group.arn
  target_id        = aws_instance.lb_instance_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "lb_inst_2" {
  target_group_arn = aws_lb_target_group.lb_group.arn
  target_id        = aws_instance.lb_instance_2.id
  port             = 80
}