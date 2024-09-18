# Pub/Sub to GCS Dataflow Pipeline

This repository contains a Dataflow pipeline that streams data from Google Cloud Pub/Sub to Google Cloud Storage (GCS) using Python.

## Setup Instructions

### Step 1: Terraform Setup

1. Initialize Terraform and apply the configuration to create the necessary resources (Pub/Sub, GCS, Dataflow).
   
   ```bash
   terraform init
   terraform apply
   ```

### Step 2: Google Cloud Configuration

1. Set your desired GCP region (e.g., `us-east1`).

   ```bash
   gcloud config set compute/region us-east1
   ```

### Step 3: Export Environment Variables

1. Set up environment variables for the bucket, Pub/Sub topic, and other configurations.

   ```bash
   export bucket_name="my-bucket-"
   export pubsub_topic_name="my-topic-"
   export scheduler_job_name="publisher-job"
   export project_id="user-ckbwuhx"
   export region="us-east1"
   ```

### Step 4: Install Dependencies

1. Install Python dependencies required for the streaming application.

   ```bash
   pip install -U -r streaming-app/requirements.txt --break-system-packages
   ```

### Step 5: Run the Dataflow Pipeline

1. Execute the Python script to stream data from Pub/Sub to GCS using Dataflow.

   ```bash
   python streaming-app/PubSubToGCS.py \
       --project=$project_id \
       --region=$region \
       --input_topic=projects/$project_id/topics/$pubsub_topic_name \
       --output_path=gs://$bucket_name/samples/output \
       --runner=DataflowRunner \
       --window_size=2 \
       --num_shards=2 \
       --temp_location=gs://$bucket_name/temp
   ```

## Components

- **Terraform**: Automates infrastructure creation for Pub/Sub, GCS, and other resources.
- **Google Cloud Pub/Sub**: Message streaming service used as the data source.
- **Google Cloud Storage**: Data is streamed and saved in this GCS bucket.
- **Apache Beam / Dataflow**: Used to process and transfer data from Pub/Sub to GCS.
  

