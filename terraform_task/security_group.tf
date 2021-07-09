###CREATE SECURITY GROUP
resource "aws_security_group" "lb_sc" {
  name        = "LB_SC"
  description = "LB_security"
  vpc_id      = aws_vpc.lb_vpc.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "LB_SC"
  }  
}