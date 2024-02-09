resource "google_storage_bucket" "bucket" {
  name     = "terraform-gcp-autozone-coding"
  location = "us-central1"
}

resource "google_storage_bucket_object" "archive" {
  name   = "index.zip"
  bucket = google_storage_bucket.bucket.name
  source = "function.zip"
}

resource "google_cloudfunctions_function" "function" {
  name                 = "function-test"
  description          = "My function"
  runtime              = "nodejs10"
  available_memory_mb  = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http         = true
  timeout              = var.function_timeout
  entry_point          = "autozone"

  labels = {
    my-label = "autozone"
  }

  environment_variables = {
    MY_ENV_VAR = "NA"
  }
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
  cloud_function = google_cloudfunctions_function.function.name
  role           = "roles/cloudfunctions.invoker"
  member         = "allUsers"
}
