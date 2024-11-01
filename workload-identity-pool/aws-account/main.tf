resource "google_iam_workload_identity_pool" "this" {
  workload_identity_pool_id = "aws-account-${var.aws_account_id}"
}

resource "google_iam_workload_identity_pool_provider" "this" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.this.workload_identity_pool_id
  workload_identity_pool_provider_id = google_iam_workload_identity_pool.this.id

  attribute_mapping = {
    "google.subject"         = "assertion.arn"
    "attribute.aws_account"  = "assertion.account"
    "attribute.aws_role_arn" = "assertion.arn"
  }

  attribute_condition = "assertion.arn.startsWith('arn:aws:sts::${var.aws_account_id}:assumed-role/')"

  aws {
    account_id = var.aws_account_id
  }
}
