###CREATE S3 BUCKET
resource "aws_s3_bucket" "lb_bucket" {
  bucket = "YOUR BUCKET"
  acl    = "private"
  force_destroy = true
  
  tags = {
    Name = "LB_bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "lb_bucket_block" {
  bucket = aws_s3_bucket.lb_bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_object" "lb_copy_index" {
  bucket = aws_s3_bucket.lb_bucket.id
  key    = "index.html"
  source = "source/index.html"
  
  etag = filemd5("source/index.html")
}