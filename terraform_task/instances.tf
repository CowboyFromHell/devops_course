###CREATE INSTANCES
resource "aws_instance" "lb_instance_1" {
  ami = "ami-0d8d212151031f51c"
  instance_type = "t2.micro"
  key_name = "doom_key"
  subnet_id = aws_subnet.lb_nat_1.id
  security_groups = [aws_security_group.lb_sc.id]
  iam_instance_profile  = aws_iam_instance_profile.web_read_s3_profile.name
  user_data = <<EOF
#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd.service
systemctl enable httpd.service
aws s3 cp s3://${aws_s3_bucket.lb_bucket.bucket}/index.html /var/www/html/
echo "$HOSTNAME" >> /var/www/html/index.html
EOF

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
  user_data = <<EOF
#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd.service
systemctl enable httpd.service
aws s3 cp s3://${aws_s3_bucket.lb_bucket.bucket}/index.html /var/www/html/
echo "$HOSTNAME" >> /var/www/html/index.html
EOF

  tags = {
    Name = "LB_int_2"
  }
}