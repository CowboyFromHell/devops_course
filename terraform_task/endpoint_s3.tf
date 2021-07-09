###CREATE ENDPOINT FOR S3
resource "aws_vpc_endpoint" "lb_endpoint" {
  vpc_id = aws_vpc.lb_vpc.id
  service_name = "com.amazonaws.us-east-2.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = [aws_route_table.lb_nat_rules.id, aws_route_table.lb_net_rules.id]
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
    Name = "LB Endpoint"
  }
}
