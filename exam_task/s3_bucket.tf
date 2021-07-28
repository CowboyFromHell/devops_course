###CREATE S3 BUCKET
resource "aws_s3_bucket" "dip_bucket" {
  bucket = "mydoombucket666"
  acl    = "private"
  force_destroy = true
  
  tags = {
    Name = "dip_bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "dip_bucket_block" {
  bucket = aws_s3_bucket.dip_bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}