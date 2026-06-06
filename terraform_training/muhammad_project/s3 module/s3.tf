resource "aws_s3_bucket" "media_assets" {
  bucket = "media-assets-bucket-terraform-training"
}

resource "aws_s3_bucket" "wordpress_code" {
  bucket = "wordpress-code-bucket-terraform-training"
}
