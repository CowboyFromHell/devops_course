###CREATE ROUTE TABLES
resource "aws_route_table" "dip_net_rules" {
  vpc_id = aws_vpc.dip_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dip_gw.id
  }

  tags = {
    Name = "dip_net_rules"
  }
}