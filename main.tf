
//this is the teraform s3 bucket
resource "aws_s3_bucket" "my-s3-bucket" {
  bucket = var.my-s3-bucket

  tags = {
    Name        = "terra-infra-s3-bucket"
    Environment = "Dev"
  }
}

// this is to apply ownership controls
resource "aws_s3_bucket_ownership_controls" "my-s3-bucket-ownership" {
  bucket = aws_s3_bucket.my-s3-bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

//this is to make sure it has public access
resource "aws_s3_bucket_public_access_block" "my-s3-bucket-public-access" {
  bucket = aws_s3_bucket.my-s3-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


//enabling acl to public
resource "aws_s3_bucket_acl" "my-s3-bucket-acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.my-s3-bucket-ownership,
    aws_s3_bucket_public_access_block.my-s3-bucket-public-access,
  ]

  bucket = aws_s3_bucket.my-s3-bucket.id
  acl    = "public-read"
}



//pushing files to the bucket
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.my-s3-bucket.id
  key    = "index.html"
  source = "pages/index.html"
  acl    = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.my-s3-bucket.id
  key    = "error.html"
  source = "pages/error.html"
  acl    = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "logo" {
  bucket = aws_s3_bucket.my-s3-bucket.id
  key    = "logo.png"
  source = "pages/logo.png"
  acl    = "public-read"
}



// this is to deploy the website
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.my-s3-bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  depends_on = [ aws_s3_bucket_acl.my-s3-bucket-acl ]
}
