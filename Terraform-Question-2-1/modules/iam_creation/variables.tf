variable "group_name" {
  type        = string
  description = "The name of the IAM group"
}

variable "user_names" {
  type        = list(string)
  description = "List of user names to add to the group"
}

variable "policy_arns" {
  type        = list(string)
  description = "List of IAM policy ARNs to attach to the group"
}