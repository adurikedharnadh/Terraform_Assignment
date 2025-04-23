provider "aws" {
  region  = "ap-south-1"
  alias   = "primary"
  profile = "default"
}

module "group1" {
  source           = "./modules/iam_creation"
  group_name       = "group1"
  user_names       = ["engine", "ci"]
  policy_arns      = ["arn:aws:iam::aws:policy/PowerUserAccess"] # or a custom limited policy
}

module "group2" {
  source           = "./modules/iam_creation"
  group_name       = "group2"
  user_names       = ["John_Doe", "Aboubacar_Maina"]
  policy_arns      = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}