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

variable "github_actions_iam_workload_identity_pool_id" {
  type = string
}

variable "github_actions_iam_workload_identity_pool_provider_id" {
  type = string
}

variable "github_repository" {
  type = string
}
