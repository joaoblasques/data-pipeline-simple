
# Terraform Block: Specifies the required providers for the project

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

# Google Provider Configuration

provider "google" {
# Credentials only needs to be set if you do not have the GOOGLE_APPLICATION_CREDENTIALS set
#  credentials = 
  project = "ny-taxi-464111"
  region  = "us-central1"
}


# Google Cloud Storage Bucket

resource "google_storage_bucket" "data-lake-bucket" {
  name          = "ny-taxi-464111-bucket"
  location      = "US"

  # Optional, but recommended settings:
  storage_class = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled     = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30  // days
    }
  }

  force_destroy = true
}

# Google BigQuery Dataset

resource "google_bigquery_dataset" "dataset" {
  dataset_id = "ny_taxi_464111_bigquery_dataset"
  project    = "ny-taxi-464111"
  location   = "US"
}
