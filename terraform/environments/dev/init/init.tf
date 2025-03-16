terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.17.0"
    }
  }

  backend "s3" {
    bucket         = "yngmin-k8s-dev-tfstate"
    key            = "terraform/environments/dev/init/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "terraform-k8s-lock-dev"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

# # S3 bucket for backend
resource "aws_s3_bucket" "tf_state" {
  bucket = "${var.account_id}-${var.environment}-tfstate"

  # 삭제 방지
  lifecycle {
    prevent_destroy = true
  }
}

# # 암호화 설정: SSE-S3 (Amazon S3 관리형 키)
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.tf_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# S3 버킷 정책
resource "aws_s3_bucket_policy" "tf_state_policy" {
  bucket = aws_s3_bucket.tf_state.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowOnlySecureAccess"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.tf_state.id}/*",
          "arn:aws:s3:::${aws_s3_bucket.tf_state.id}"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}


# # S3 bucket versioning
resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# DynamoDB for terraform state lock
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "terraform-k8s-lock-${var.environment}"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }
}

variable "environment" {
  default = "dev"
}

variable "account_id" {
  default = "yngmin-k8s"
}
