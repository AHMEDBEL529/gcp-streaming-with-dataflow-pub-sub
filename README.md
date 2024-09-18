# Streaming Application with Terraform, Dataflow, and Pub/Sub

This repository contains the setup for deploying a streaming pipeline using Terraform, Dataflow, and Pub/Sub. The setup includes deploying resources via Terraform, streaming data from Pub/Sub, and saving the output to Google Cloud Storage (GCS).

## Getting Started

### Step 1: Set Up Google Cloud Project and Region

Retrieve the project ID and set the region in your `gcloud` configuration.

```bash
# Get project ID and region from gcloud config
PROJECT_ID=$(gcloud config get-value project)
gcloud config set compute/region us-central1
REGION=$(gcloud config get-value compute/region)

# Update terraform.tfvars with the retrieved values
sed -i "s/^project_id.*/project_id = "$PROJECT_ID"/" terraform.tfvars
sed -i "s/^region.*/region = "$REGION"/" terraform.tfvars

echo "Updated terraform.tfvars with project_id = $PROJECT_ID and region = $REGION"
```

This command will retrieve your project ID and region from the `gcloud` configuration and update your `terraform.tfvars` accordingly.

### Step 2: Initialize and Apply Terraform

Run the following commands to initialize Terraform and apply the configuration:

```bash
terraform init
terraform apply
```

### Step 3: Set Environment Variables

After applying Terraform, use the outputs to set the required environment variables for your Pub/Sub topic and Google Cloud Storage bucket:

```bash
export bucket_name="my-bucket-be57ff1b"
export pubsub_topic_name="my-topic-be57ff1b"
export scheduler_job_name="publisher-job"
```

### Step 4: Install Python Dependencies

Navigate to the streaming app folder and install the necessary Python dependencies:

```bash
pip install -U -r streaming-app/requirements.txt --break-system-packages
```

### Step 5: Run the Streaming Application

Execute the streaming application, which streams data from Pub/Sub to Google Cloud Storage using Dataflow:

```bash
python streaming-app/PubSubToGCS.py     --project=$PROJECT_ID     --region=$REGION    --input_topic=projects/$PROJECT_ID/topics/$pubsub_topic_name     --output_path=gs://$bucket_name/samples/output     --runner=DataflowRunner     --window_size=2     --num_shards=2     --temp_location=gs://$bucket_name/temp
```

This command will start the streaming pipeline that ingests data from Pub/Sub and writes it to a specified Cloud Storage bucket.
