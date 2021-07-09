###CREATE SUBNETS
resource "aws_subnet" "lb_nat_1" {
  vpc_id     = aws_vpc.lb_vpc.id
  cidr_block = "10.10.1.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "LB_nat_1"
  }
}

resource "aws_subnet" "lb_nat_2" {
  vpc_id     = aws_vpc.lb_vpc.id
  cidr_block = "10.10.2.0/24"
  availability_zone = "us-east-2b"
  tags = {
    Name = "LB_nat_2"
  }
}

resource "aws_subnet" "lb_net_1" {
  vpc_id     = aws_vpc.lb_vpc.id
  cidr_block = "10.10.3.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "LB_net_1"
  }
}

resource "aws_subnet" "lb_net_2" {
  vpc_id     = aws_vpc.lb_vpc.id
  cidr_block = "10.10.4.0/24"
  availability_zone = "us-east-2b"
  tags = {
    Name = "LB_net_2"
  }
}

resource "aws_subnet" "lb_net_3" {
  vpc_id     = aws_vpc.lb_vpc.id
  cidr_block = "10.10.5.0/24"
  availability_zone = "us-east-2c"
  tags = {
    Name = "LB_FORNATGW_3"
  }
}