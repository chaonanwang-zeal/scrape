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
  schema = <<EOF
[
  {
    "name": "permalink",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "The Permalink"
  },
  {
    "name": "state",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "State where the head office is located"
  }
]
EOF
}
