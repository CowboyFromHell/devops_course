###CREATE SECURITY GROUP
resource "aws_security_group" "dip_sc" {
  name        = "dip_SC"
  description = "dip_security"
  vpc_id      = aws_vpc.dip_vpc.id

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
    Name = "dip_SC"
  }  
}