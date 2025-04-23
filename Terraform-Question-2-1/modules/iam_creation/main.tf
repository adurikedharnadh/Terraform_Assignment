resource "aws_iam_group" "this" {
  name = var.group_name
}

resource "aws_iam_group_policy_attachment" "attachments" {
  for_each = toset(var.policy_arns)

  group      = aws_iam_group.this.name
  policy_arn = each.key
}

resource "aws_iam_user" "users" {
  for_each = toset(var.user_names)

  name = each.key
}

resource "aws_iam_user_group_membership" "group_membership" {
  for_each = toset(var.user_names)

  user = each.key
  groups = [aws_iam_group.this.name]
}