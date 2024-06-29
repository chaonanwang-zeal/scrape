resource "google_bigquery_table" "user_table" {
  dataset_id = google_bigquery_dataset.user_dataset.dataset_id
  table_id   = "user_table"
  schema     = jsonencode([
    {
      "name": "id",
      "type": "INTEGER"
    },
    {
      "name": "username",
      "type": "STRING"
    },
    {
      "name": "email",
      "type": "STRING"
    }
  ])
}
