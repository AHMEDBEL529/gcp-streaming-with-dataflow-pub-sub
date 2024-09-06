# Enable Dataflow API
resource "google_project_service" "dataflow" {
  service = "dataflow.googleapis.com"
}

# Enable Pub/Sub API
resource "google_project_service" "pubsub" {
  service = "pubsub.googleapis.com"
}

# Enable Cloud Scheduler API
resource "google_project_service" "scheduler" {
  service = "cloudscheduler.googleapis.com"
}

# Enable App Engine API
resource "google_project_service" "appengine" {
  service = "appengine.googleapis.com"
}


# Generate a random suffix for the bucket name
resource "random_id" "bucket_suffix" {
  byte_length = var.random_suffix_byte_length  # Uses the variable for byte length
}

# Create the bucket with a random name
resource "google_storage_bucket" "bucket" {
  name     = "my-bucket-${random_id.bucket_suffix.hex}"
  location = "US"
}

# Create a Pub/Sub topic
resource "google_pubsub_topic" "my_topic" {
  name = "my-topic-${random_id.bucket_suffix.hex}"
}

# Create a Pub/Sub subscription for the topic
resource "google_pubsub_subscription" "subscription" {
  name  = "job-topic-subscription"
  topic = google_pubsub_topic.my_topic.id
}

# Create a Cloud Scheduler job to publish to the Pub/Sub topic
resource "google_cloud_scheduler_job" "pubsub_job" {
  name        = "publisher-job"
  description = "A job to publish messages to a Pub/Sub topic every minute"
  schedule    = var.pubsub_job_schedule  # Uses the schedule variable
  time_zone   = "UTC"
  region      = var.region  # Uses the region variable

  pubsub_target {
    topic_name = google_pubsub_topic.my_topic.id
    data       = base64encode(var.pubsub_message)  # Uses the message variable
  }
}

# Create an App Engine application
resource "google_app_engine_application" "app" {
  project     = var.project_id
  location_id = "us-central"  # Use the region variable for App Engine location
}
