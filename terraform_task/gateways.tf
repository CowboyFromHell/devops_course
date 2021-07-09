###CREATE GATEWAYS
resource "aws_internet_gateway" "lb_gw" {
  vpc_id = aws_vpc.lb_vpc.id

  tags = {
    Name = "LB_GW"
  }
}


resource "aws_eip" "lb_ei" {
  tags = {
    Name = "LB_el_ip"
  }
}

resource "aws_nat_gateway" "lb_nat_gw" {
  allocation_id = aws_eip.lb_ei.id
  subnet_id = aws_subnet.lb_net_3.id

  tags = {
    Name = "LB_NAT_GW"
  }

}