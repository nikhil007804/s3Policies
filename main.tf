resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  tags = {
    env = "dev"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "example_lifecycle" {
  bucket = aws_s3_bucket.example.id

  rule {
    id     = "move-older-than-30-days"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }
}

// Remove or update the bucket policy if you cannot allow public access
# resource "aws_s3_bucket_policy" "example_policy" {
#   bucket = aws_s3_bucket.example.id
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = "*"
#         Action = "s3:GetObject"
#         Resource = "${aws_s3_bucket.example.arn}/*"
#       }
#     ]
#   })
# }