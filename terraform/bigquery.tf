resource "google_bigquery_table" "terra_table" {
  dataset_id = "oh_practice"
  table_id   = "terra_table"

  schema = jsonencode([
    {
      name = "column1",
      type = "STRING"
    }
  ])
}
