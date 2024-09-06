# Declare the variable for the Pub/Sub message
variable "pubsub_message" {
  description = "Message to be published by the Pub/Sub job"
  type        = string
  default     = "Hello!"
}

# Declare the variable for the Pub/Sub job schedule
variable "pubsub_job_schedule" {
  description = "Schedule for the Pub/Sub job in cron format"
  type        = string
  default     = "* * * * *"  # Runs every minute
}

# Declare the variable for the random suffix byte length
variable "random_suffix_byte_length" {
  description = "Number of bytes to use for generating the random suffix"
  type        = number
  default     = 4
}

# Declare the project ID
variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

# Declare the region
variable "region" {
  description = "The region to deploy resources"
  type        = string
  default     = "us-central1"
}

# Declare the region
variable "ae_region" {
  description = "The region to deploy resources"
  type        = string
  default     = "us-central"
}
