resource "google_bigquery_table" "terra_table" {
  deletion_protection = False
  dataset_id = "oh_practice"
  table_id   = "terra_table"

  schema = jsonencode([
    {
      name = "column1",
      type = "STRING"
    },
    {
      name = "column2",
      type = "INTEGER"
    },
    {
      name = "column3",
      type = "INTEGER"
    }
  ])
}

resource "google_bigquery_table" "terra_view" {
  dataset_id = "oh_practice"
  table_id   = "terra_table_view"

  view {
    query          = "SELECT column1, column2 FROM `${google_bigquery_table.terra_table.project}.${google_bigquery_table.terra_table.dataset_id}.${google_bigquery_table.terra_table.table_id}`"
    use_legacy_sql = false
  }
  depends_on = [google_bigquery_table.terra_table]
}
