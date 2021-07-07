terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

###CREATE VPC
resource "aws_vpc" "lb_vpc" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "LB_VPC"
  }
}


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


###ASSOCIATE SUBNETS WITH ROUTE TABLES
resource "aws_route_table_association" "nat_associate_1" {
  subnet_id      = aws_subnet.lb_nat_1.id
  route_table_id = aws_route_table.lb_nat_rules.id
}

resource "aws_route_table_association" "nat_associate_2" {
  subnet_id      = aws_subnet.lb_nat_2.id
  route_table_id = aws_route_table.lb_nat_rules.id
}

resource "aws_route_table_association" "net_associate_1" {
  subnet_id      = aws_subnet.lb_net_1.id
  route_table_id = aws_route_table.lb_net_rules.id
}

resource "aws_route_table_association" "net_associate_2" {
  subnet_id      = aws_subnet.lb_net_2.id
  route_table_id = aws_route_table.lb_net_rules.id
}

resource "aws_route_table_association" "net_associate_3" {
  subnet_id      = aws_subnet.lb_net_3.id
  route_table_id = aws_route_table.lb_net_rules.id
}

###CREATE SECURITY GROUP
resource "aws_security_group" "lb_sc" {
  name        = "LB_SC"
  description = "LB_security"
  vpc_id      = aws_vpc.lb_vpc.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # ingress {
  #   from_port        = 1025
  #   to_port          = 65535
  #   protocol         = "tcp"
  #   cidr_blocks      = ["0.0.0.0/0"]
  # }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "LB_SC"
  }  
}

###CREATE RULES FOR NET ACL
resource "aws_default_network_acl" "jenk_net_acl" {
  default_network_acl_id = aws_vpc.lb_vpc.default_network_acl_id

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 101
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 102
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 103
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1025
    to_port    = 65535
  }

  egress {
    protocol   = "tcp"
    rule_no    = 104
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1025
    to_port    = 65535
  }

  egress {
    protocol   = "tcp"
    rule_no    = 105
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  egress {
    protocol   = "tcp"
    rule_no    = 106
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  egress {
    protocol   = "tcp"
    rule_no    = 107
    action     = "allow"
    cidr_block = "10.10.0.0/16"
    from_port  = 22
    to_port    = 22
  }

  tags = {
    Name = "LB_net_acl"
  }  
}

###CREATE ROLE

# resource "aws_iam_user" "web_read_s3_user" {
#   name = "web_read_s3"
# }

resource "aws_iam_role" "web_read_s3_role" {
  name = "web_read_s3"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# resource "aws_iam_group" "web_read_s3_group" {
#   name = "web_read_s3"
# }

# resource "aws_iam_group_membership" "web_read_s3_group_members" {
#   name = "tf-testing-group-membership"

#   users = [
#     aws_iam_user.web_read_s3_user.name,
#   ]

#   group = aws_iam_group.web_read_s3_group.name
# }

resource "aws_iam_policy" "web_read_s3_policy" {
  name        = "web_read_s3"
  description = "Web read s3"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Effect": "Allow",
          "Action": [
              "s3:Get*",
              "s3:List*"
          ],
          "Resource": "*"
      }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "web_read_s3_attach" {
  name       = "web read s3 attachment"
  # users      = [aws_iam_user.web_read_s3_user.name]
  roles      = [aws_iam_role.web_read_s3_role.name]
  # groups     = [aws_iam_group.web_read_s3_group.name]
  policy_arn = aws_iam_policy.web_read_s3_policy.arn
}

resource "aws_iam_instance_profile" "web_read_s3_profile" {
  name = "web_read_s3"
  role = aws_iam_role.web_read_s3_role.name
}

###CREATE INSTANCES
resource "aws_instance" "lb_instance_1" {
  ami = "ami-0d8d212151031f51c"
  instance_type = "t2.micro"
  key_name = "doom_key"
  subnet_id = aws_subnet.lb_nat_1.id
  security_groups = [aws_security_group.lb_sc.id]
  iam_instance_profile  = aws_iam_instance_profile.web_read_s3_profile.name
  user_data = file("data_inst")

  tags = {
    Name = "LB_int_1"
  }
}

resource "aws_instance" "lb_instance_2" {
  ami = "ami-0d8d212151031f51c"
  instance_type = "t2.micro"
  key_name = "doom_key"
  subnet_id = aws_subnet.lb_nat_2.id
  security_groups = [aws_security_group.lb_sc.id]
  iam_instance_profile  = aws_iam_instance_profile.web_read_s3_profile.name
  user_data = file("data_inst")

  tags = {
    Name = "LB_int_2"
  }
}

###CREATE TARGETS GROUP
resource "aws_lb_target_group" "lb_group" {
  name     = "http"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  health_check {
    interval = 15
    path = "/index.html"
  }
  vpc_id   = aws_vpc.lb_vpc.id
}

###ATTACH INSTANCES
resource "aws_lb_target_group_attachment" "lb_inst_1" {
  target_group_arn = aws_lb_target_group.lb_group.arn
  target_id        = aws_instance.lb_instance_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "lb_inst_2" {
  target_group_arn = aws_lb_target_group.lb_group.arn
  target_id        = aws_instance.lb_instance_2.id
  port             = 80
}

###CREATE LOAD BALLANCER
resource "aws_lb" "lb_main" {
  name               = "http-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sc.id]
  subnets            = [aws_subnet.lb_net_1.id, aws_subnet.lb_net_2.id]

  tags = {
    Environment = "LB_MAIN"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.lb_main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_group.arn
  }
}


output "lb_dns_name" {
  value = aws_lb.lb_main.dns_name
}