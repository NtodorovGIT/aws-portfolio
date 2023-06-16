resource "aws_s3_bucket" "state_s3_bucket" {
  bucket = "state-file-bucket-ntjgf"
  lifecycle {
    prevent_destroy = "false"
  }
}
resource "aws_s3_bucket_versioning" "s3-version" {
  bucket = aws_s3_bucket.state_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "s3_acl" {
  bucket = aws_s3_bucket.state_s3_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "bucket_version" {
  bucket = aws_s3_bucket.state_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption_config" {
  bucket = aws_s3_bucket.state_s3_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket                  = aws_s3_bucket.state_s3_bucket.id
  restrict_public_buckets = "true"
  ignore_public_acls      = "true"
  block_public_acls       = "true"
  block_public_policy     = "true"
}
