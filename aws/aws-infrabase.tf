# Infrabase Lock
resource "aws_dynamodb_table" "gourmet-infrabase-lock" {
    name = "InfrabaseLock"
    read_capacity = 5
    write_capacity = 5
    hash_key = "LockID"

    attribute {
      name = "LockID"
      type = "S"
    }
}

# Log Bucket
resource "aws_s3_bucket" "gourmet-infrabase-log" {
    bucket = "gourmet-infrabase.log"
}

# Log Bucket ACL
resource "aws_s3_bucket_acl" "gourmet-infrabase-log" {
    bucket = aws_s3_bucket.gourmet-infrabase-log.id
    acl = "log-delivery-write"
}

# Infrabase Bucket
resource "aws_s3_bucket" "gourmet-infrabase" {
    bucket = "gourmet-infrabase"
    tags = {
        Name = "infrabase"
    }
    lifecycle {
      prevent_destroy = true
    }
}

# Infrabase Bucket Versioning
resource "aws_s3_bucket_versioning" "gourmet-infrabase" {
    bucket = aws_s3_bucket.gourmet-infrabase.id
    versioning_configuration {
      status = "Enabled"
    }
}

# Infrabase Bucket Logging
resource "aws_s3_bucket_logging" "gourmet-infrabase" {
    bucket = aws_s3_bucket.gourmet-infrabase.id
    target_bucket = aws_s3_bucket.gourmet-infrabase-log.id
    target_prefix = "log/"
}

# Infrabase Bucket ACL
resource "aws_s3_bucket_acl" "gourmet-infrabase" {
    bucket = aws_s3_bucket.gourmet-infrabase.id
    acl = "private"
}
