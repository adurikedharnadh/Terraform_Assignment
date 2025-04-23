provider "aws" {
  region = "ap-south-1"
  alias  = "main"
}

# RoleA - Admin excluding IAM
resource "aws_iam_role" "roleA" {
  name = "roleA"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = "*"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "admin_without_iam" {
  name        = "AdminWithoutIAM"
  description = "Provides admin access to all services except IAM"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"
      },
      {
        Effect   = "Deny"
        Action   = "iam:*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_admin_without_iam" {
  role       = aws_iam_role.roleA.name
  policy_arn = aws_iam_policy.admin_without_iam.arn
}

# RoleB - Can assume roleC in another account
resource "aws_iam_role" "roleB" {
  name = "roleB"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"  # Example service principal
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "assume_roleC_policy" {
  name        = "AssumeRoleCPolicy"
  description = "Allows assuming roleC in account 111111111111"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Resource = "arn:aws:iam::<add the account ID of Account 111111111111>:role/roleC"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_assume_roleC" {
  role       = aws_iam_role.roleB.name
  policy_arn = aws_iam_policy.assume_roleC_policy.arn
}
