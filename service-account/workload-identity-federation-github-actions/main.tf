data "google_iam_workload_identity_pool" "github_actions" {
  provider = google-beta

  workload_identity_pool_id = var.github_actions_iam_workload_identity_pool_id
}

data "google_iam_workload_identity_pool_provider" "github_actions" {
  provider = google-beta

  workload_identity_pool_id          = var.github_actions_iam_workload_identity_pool_id
  workload_identity_pool_provider_id = var.github_actions_iam_workload_identity_pool_provider_id

  lifecycle {
    postcondition {
      condition     = self.oidc[0].issuer_uri == "https://token.actions.githubusercontent.com"
      error_message = "The specificed workload identity pool provider is not configured for federation with Github Actions."
    }
  }
}

resource "google_service_account" "this" {
  account_id  = var.account_id
  description = var.description
}

resource "google_project_iam_member" "role" {
  for_each = toset(var.iam_member_roles)

  project = var.project_id
  role    = "roles/${each.value}"
  member  = "serviceAccount:${google_service_account.this.email}"
}

resource "google_service_account_iam_member" "github_repository_workload_identity_user" {
  service_account_id = google_service_account.this.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${data.google_iam_workload_identity_pool.github_actions.name}/attribute.repository/${var.github_actions_repository}"
}
