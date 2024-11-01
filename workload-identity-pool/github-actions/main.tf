resource "google_iam_workload_identity_pool" "this" {
  provider = google-beta

  workload_identity_pool_id = var.id != null ? var.id : "github-actions-${var.github_organization}"
}

resource "google_iam_workload_identity_pool_provider" "this" {
  provider = google-beta

  workload_identity_pool_id          = google_iam_workload_identity_pool.this.workload_identity_pool_id
  workload_identity_pool_provider_id = google_iam_workload_identity_pool.this.id

  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.aud"              = "assertion.aud"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }

  attribute_condition = "assertion.repository_owner == '${var.github_organization}'"

  oidc {
    issuer_uri        = "https://token.actions.githubusercontent.com"
    allowed_audiences = []
  }
}
