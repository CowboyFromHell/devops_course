###CREATE VPC
resource "aws_vpc" "lb_vpc" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "LB_VPC"
  }
}