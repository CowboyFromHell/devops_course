###ASSOCIATE SUBNETS WITH ROUTE TABLES
resource "aws_route_table_association" "net_associate_1" {
  subnet_id      = aws_subnet.dip_net_1.id
  route_table_id = aws_route_table.dip_net_rules.id
}

resource "aws_route_table_association" "net_associate_2" {
  subnet_id      = aws_subnet.dip_net_2.id
  route_table_id = aws_route_table.dip_net_rules.id
}

resource "aws_route_table_association" "net_associate_3" {
  subnet_id      = aws_subnet.dip_net_3.id
  route_table_id = aws_route_table.dip_net_rules.id
}