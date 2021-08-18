# Store state in S3 and lock in DynamoDB

# Terraform User
data "aws_iam_user" "terraform" {
  user_name = "terraform"
}

# Bucket
resource "aws_s3_bucket" "netmiko-ebs-tfremotestate" {
  bucket        = "netmiko-ebs-tfremotestate"
  force_destroy = true
  acl           = "private"

  # Grant read/write access to the terraform user
  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${data.aws_iam_user.terraform.arn}"
            },
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::netmiko-ebs-tfremotestate/*"
        }
    ]
}
EOF
}

resource "aws_s3_bucket_public_access_block" "red30-tfremotestate" {
  bucket = aws_s3_bucket.netmiko-ebs-tfremotestate.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_dynamodb_table" "tf_db_statelock" {
  name           = "red30-tfstatelock"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_iam_user_policy" "terraform_user_dbtable" {
  name   = "terraform"
  user   = data.aws_iam_user.terraform.user_name
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": ["dynamodb:*"],
            "Resource": [
                "${aws_dynamodb_table.tf_db_statelock.arn}"
            ]
        }
   ]
}
EOF
}