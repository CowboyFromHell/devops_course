###CREATE ROLE
resource "aws_iam_role" "dip_rw_s3_role" {
  name = "dip_read_s3"
  #assume_role_policy = file("source/iam_assume_role_policy.json")
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


resource "aws_iam_policy" "dip_rw_s3_policy" {
  name        = "dip_rw_s3"
  description = "dip rw s3"
  #policy = file("source/iam_role_policy.json")
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket",
                "s3:DeleteObject"
            ],
            "Resource": [
                "${aws_s3_bucket.dip_bucket.arn}",
                "${aws_s3_bucket.dip_bucket.arn}/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "dip_rw_s3_attach" {
  name       = "dip rw s3 attachment"
  roles      = [aws_iam_role.dip_rw_s3_role.name]
  policy_arn = aws_iam_policy.dip_rw_s3_policy.arn
}

resource "aws_iam_instance_profile" "dip_rw_s3_profile" {
  name = "dip_rw_s3_profile"
  role = aws_iam_role.dip_rw_s3_role.name
}