output "id" {
  value = google_service_account.this.id
}

output "name" {
  value = google_service_account.this.name
}

output "email" {
  value = google_service_account.this.email
}

output "workload_identity_pool_name" {
  value = data.google_iam_workload_identity_pool.aws.name
}

output "workload_identity_pool_provider_name" {
  value = data.google_iam_workload_identity_pool_provider.aws.name
}
