provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_bigquery_dataset" "account_dataset" {
  dataset_id = "account"
  location   = var.region
}

resource "google_bigquery_table" "accountid" {
  dataset_id = google_bigquery_dataset.account_dataset.dataset_id
  table_id   = "accountid"
  schema     = jsonencode([
    {
      "name": "account_id",
      "type": "INTEGER"
    },
    {
      "name": "user_id",
      "type": "INTEGER"
    }
  ])
}

resource "google_bigquery_table" "accountdetail" {
  dataset_id = google_bigquery_dataset.account_dataset.dataset_id
  table_id   = "accountdetail"
  schema     = jsonencode([
    {
      "name": "account_id",
      "type": "INTEGER"
    },
    {
      "name": "details",
      "type": "STRING"
    }
  ])
}
