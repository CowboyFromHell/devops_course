###CREATE RULES FOR NET ACL
locals {
  rules_in = [{
    protocol   = "tcp",
    rule_no    = 100,
    action     = "allow",
    cidr_block = "0.0.0.0/0",
    from_port  = 80,
    to_port    = 80,
  },{
    protocol   = "tcp",
    rule_no    = 101,
    action     = "allow",
    cidr_block = "0.0.0.0/0",
    from_port  = 443,
    to_port    = 443,
  },{
    protocol   = "tcp",
    rule_no    = 102,
    action     = "allow",
    cidr_block = "0.0.0.0/0",
    from_port  = 22,
    to_port    = 22,
  },{
    protocol   = "tcp",
    rule_no    = 103,
    action     = "allow",
    cidr_block = "0.0.0.0/0",
    from_port  = 1025,
    to_port    = 65535,
  },{
    protocol   = -1,
    rule_no    = 104,
    action     = "allow",
    cidr_block = "10.10.0.0/16",
    from_port  = 0,
    to_port    = 0,
  }]

  rules_out = [{
    protocol   = "tcp"
    rule_no    = 105
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  },{
    protocol   = "tcp"
    rule_no    = 106
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  },{
    protocol   = "tcp"
    rule_no    = 107
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1025
    to_port    = 65535
  },{
    protocol   = -1,
    rule_no    = 108,
    action     = "allow",
    cidr_block = "10.10.0.0/16",
    from_port  = 0,
    to_port    = 0,
  }]
}

resource "aws_default_network_acl" "dip_net_acl" {
  default_network_acl_id = aws_vpc.dip_vpc.default_network_acl_id

  dynamic "ingress" {
    for_each = local.rules_in
    content {
      protocol   = ingress.value.protocol
      rule_no    = ingress.value.rule_no
      action     = ingress.value.action
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  dynamic "egress" {
    for_each = local.rules_out
    content {
      protocol   = egress.value.protocol
      rule_no    = egress.value.rule_no
      action     = egress.value.action
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
    }
  }

  tags = {
    Name = "dip_net_acl"
  }  
}