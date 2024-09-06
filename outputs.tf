# Outputs for useful information
output "bucket_name" {
  description = "The name of the created storage bucket"
  value       = google_storage_bucket.bucket.name
}

output "pubsub_topic_name" {
  description = "The name of the created Pub/Sub topic"
  value       = google_pubsub_topic.my_topic.name
}

output "scheduler_job_name" {
  description = "The name of the Cloud Scheduler job"
  value       = google_cloud_scheduler_job.pubsub_job.name
}
