###CREATE VPC
resource "aws_vpc" "dip_vpc" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "dip_vpc"
  }
}