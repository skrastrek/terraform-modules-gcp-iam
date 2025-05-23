variable "account_id" {
  type = string
}

variable "description" {
  type    = string
  default = null
}

variable "project_id" {
  type = string
}

variable "iam_member_roles" {
  type    = list(string)
  default = []
}

variable "aws_assumed_role_arns" {
  type        = set(string)
  description = "The AWS IAM assumed roles that are allowed to authenticate as the GCP service account."
}

variable "aws_iam_workload_identity_pool_id" {
  type = string
}

variable "aws_iam_workload_identity_pool_provider_id" {
  type = string
}
