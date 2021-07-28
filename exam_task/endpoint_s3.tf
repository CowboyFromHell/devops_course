###CREATE ENDPOINT FOR S3
resource "aws_vpc_endpoint" "dip_endpoint" {
  vpc_id = aws_vpc.dip_vpc.id
  service_name = "com.amazonaws.us-east-2.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = [aws_route_table.dip_net_rules.id]
  policy = <<EOF
{
    "Statement": [
        {
            "Action": "*",
            "Effect": "Allow",
            "Resource": "*",
            "Principal": "*"
        }
    ]
}
EOF
  tags = {
    Name = "dip endpoint"
  }
}
