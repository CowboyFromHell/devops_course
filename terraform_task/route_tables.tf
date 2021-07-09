###CREATE ROUTE TABLES
resource "aws_route_table" "lb_nat_rules" {
  vpc_id = aws_vpc.lb_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.lb_nat_gw.id
  }

  tags = {
    Name = "LB_nat_rules"
  }
}

resource "aws_route_table" "lb_net_rules" {
  vpc_id = aws_vpc.lb_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lb_gw.id
  }

  tags = {
    Name = "LB_net_rules"
  }
}