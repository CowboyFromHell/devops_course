###CREATE ROLE

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
          "Resource": "${aws_s3_bucket.lb_bucket.arn}/*"
      }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "web_read_s3_attach" {
  name       = "web read s3 attachment"
  roles      = [aws_iam_role.web_read_s3_role.name]
  policy_arn = aws_iam_policy.web_read_s3_policy.arn
}

resource "aws_iam_instance_profile" "web_read_s3_profile" {
  name = "web_read_s3_profile"
  role = aws_iam_role.web_read_s3_role.name
}