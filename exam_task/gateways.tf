###CREATE GATEWAYS
resource "aws_internet_gateway" "dip_gw" {
  vpc_id = aws_vpc.dip_vpc.id

  tags = {
    Name = "dip_GW"
  }
}