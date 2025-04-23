provider "aws" {
  alias  = "account1111"
  region = "ap-south-1" 
  profile = "222634405778"
}

resource "aws_iam_role" "roleC" {
  name               = "roleC"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = "arn:aws:iam::891377060712:role/roleB"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  provider = aws.account1111
}

resource "aws_iam_policy" "s3_full_access" {
  name        = "S3FullAccessToSpecificBucket"
  description = "Full access to aws-test-bucket"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "s3:*",
        Resource = [
          "arn:aws:s3:::aws-test-bucket",
          "arn:aws:s3:::aws-test-bucket/*"
        ]
      }
    ]
  })

  provider = aws.account1111
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.roleC.name
  policy_arn = aws_iam_policy.s3_full_access.arn

  provider = aws.account1111
}
