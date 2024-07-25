provider "aws" {
  region = "us-west-2" # Update to your region
}

resource "aws_iam_user" "user" {
  name = "access-user-${var.user_name}"
}

resource "aws_iam_user_policy" "user_policy" {
  name   = "S3AccessPolicy-${var.user_name}"
  user   = aws_iam_user.user.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:*"
        Resource = [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      }
    ]
  })
}

output "user_arn" {
  value = aws_iam_user.user.arn
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "user_name" {
  description = "The name of the user requesting access"
  type        = string
}
