###CREATE SUBNETS
resource "aws_subnet" "dip_net_1" {
  vpc_id     = aws_vpc.dip_vpc.id
  cidr_block = "10.10.3.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "dip_net_1"
  }
}

resource "aws_subnet" "dip_net_2" {
  vpc_id     = aws_vpc.dip_vpc.id
  cidr_block = "10.10.4.0/24"
  availability_zone = "us-east-2b"
  tags = {
    Name = "dip_net_2"
  }
}

resource "aws_subnet" "dip_net_3" {
  vpc_id     = aws_vpc.dip_vpc.id
  cidr_block = "10.10.5.0/24"
  availability_zone = "us-east-2c"
  tags = {
    Name = "dip_services_3"
  }
}