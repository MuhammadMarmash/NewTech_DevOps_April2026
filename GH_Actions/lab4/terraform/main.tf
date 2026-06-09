terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Partial backend configuration.
  # Supply the bucket name at init  time:
  #   Local:  terraform init -backend-config="bucket=YOUR-STATE-BUCKET"
  #   CI:     terraform init -backend-config="bucket=${{ secrets.TF_STATE_BUCKET }}"
  backend "s3" {
    key    = "lab4/terraform.tfstate"
    region = "eu-north-1"
  }
}

provider "aws" {
  region = var.aws_region
}

# ── S3 Bucket ──────────────────────────────────────────────────────────────────

resource "aws_s3_bucket" "app_storage" {
  #checkov:skip=CKV_AWS_18:Access logging needs a dedicated log bucket — out of scope for a single lab bucket
  #checkov:skip=CKV_AWS_144:Cross-region replication needs a second region/bucket/IAM role — out of scope for this lab
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

# ── Public Access Block ────────────────────────────────────────────────────────

resource "aws_s3_bucket_public_access_block" "app_storage" {
  bucket = aws_s3_bucket.app_storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ── Versioning ─────────────────────────────────────────────────────────────────

resource "aws_s3_bucket_versioning" "app_storage" {
  bucket = aws_s3_bucket.app_storage.id

  versioning_configuration {
    status = "Enabled"
  }
}

# ── Encryption (KMS) ─────────────────────────────────────────────────────────────
# CKV_AWS_145 — requires aws:kms (not AES256). Uses the AWS-managed aws/s3 key.

resource "aws_s3_bucket_server_side_encryption_configuration" "app_storage" {
  bucket = aws_s3_bucket.app_storage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

# ── Lifecycle ────────────────────────────────────────────────────────────────────
# CKV2_AWS_61 — expire old non-current versions so the bucket doesn't grow forever.

resource "aws_s3_bucket_lifecycle_configuration" "app_storage" {
  bucket = aws_s3_bucket.app_storage.id

  rule {
    id     = "expire-noncurrent-versions"
    status = "Enabled"

    filter {}

    noncurrent_version_expiration {
      noncurrent_days = 90
    }

    # CKV_AWS_300 — clean up failed/incomplete multipart uploads.
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

# ── Event Notifications ──────────────────────────────────────────────────────────
# CKV2_AWS_62 — enabling EventBridge satisfies the check without needing an external
# SNS/SQS/Lambda target.

resource "aws_s3_bucket_notification" "app_storage" {
  bucket      = aws_s3_bucket.app_storage.id
  eventbridge = true
}
