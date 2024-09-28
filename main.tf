provider "aws" {
  region = var.region
  assume_role {
    role_arn = "arn:aws:iam::${var.accountnumber}:role/devDeploymentRole"
  }
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

data "archive_file" "zip_the_code" {
  type        = "zip"
  source_dir  = "./src/nodejs"
  output_path = "chromium.zip"
}

resource "aws_s3_bucket" "mybucks" {
  bucket = "layers-chromium-v2"
  tags = {
  }
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.mybucks.arn
}

output "bucket_id" {
  value = aws_s3_bucket.mybucks.id
}

resource "aws_s3_bucket_object" "lambda_layer_zip" {
  bucket = aws_s3_bucket.mybucks.id
  key    = "chromiumLayer.zip"
  source = "data.archive_file.zip_the_code.output_path"
  content_type = "data.archive_file.zip_the_code.type"
  kms_ley_id="arn:aws:kms:${var.region}:${var.accountnumber}:key/012n98we-34g7-8b5-0bw1-0129f0456vk"
}

resource "aws_lambda_layer_version" "lambda_layer" {
  s3_key      = aws_s3_bucket_object.lambda_layer_zip.key
  s3_bucket   = aws_s3_bucket.lambda_layer_zip.bucket
  layer_name  = "lambda-layer-chromium-v3"
  compatible_runtimes = ["nodejs16.x"]
}