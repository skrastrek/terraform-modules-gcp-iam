data "google_iam_workload_identity_pool" "aws" {
  provider = google-beta

  workload_identity_pool_id = var.aws_iam_workload_identity_pool_id
}

data "google_iam_workload_identity_pool_provider" "aws" {
  provider = google-beta

  workload_identity_pool_id          = var.aws_iam_workload_identity_pool_id
  workload_identity_pool_provider_id = var.aws_iam_workload_identity_pool_provider_id

  lifecycle {
    postcondition {
      condition     = self.aws[0] != null
      error_message = "The specificed workload identity pool provider is not configured for federation with AWS."
    }
  }
}

resource "google_service_account" "this" {
  provider = google-beta

  account_id  = var.account_id
  description = var.description
}

resource "google_project_iam_member" "role" {
  provider = google-beta

  for_each = toset(var.iam_member_roles)

  project = var.project_id
  role    = "roles/${each.value}"
  member  = "serviceAccount:${google_service_account.this.email}"
}

resource "google_service_account_iam_member" "aws_assumed_role_workload_identity_user" {
  provider = google-beta

  for_each = var.aws_assumed_role_arns

  service_account_id = google_service_account.this.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${data.google_iam_workload_identity_pool.aws.name}/attribute.aws_role_arn/${each.value}"
}
