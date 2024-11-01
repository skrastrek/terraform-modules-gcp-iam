output "id" {
  value = google_iam_workload_identity_pool.this.workload_identity_pool_id
}

output "provider_id" {
  value = google_iam_workload_identity_pool_provider.this.workload_identity_pool_provider_id
}
