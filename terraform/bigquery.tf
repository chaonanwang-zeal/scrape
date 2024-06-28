resource "google_bigquery_table" "terra_table" {
  dataset_id = "oh_practice"
  table_id   = "terra_table"
  deletion_protection = false  // 添加这一行
  schema = jsonencode([
    {
      name = "column1",
      type = "STRING"
    },
    {
      name = "column2",
      type = "STRING"
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
  deletion_protection = false  // 添加这一行
  view {
    query          = "SELECT column1, column2 FROM `${google_bigquery_table.terra_table.project}.${google_bigquery_table.terra_table.dataset_id}.${google_bigquery_table.terra_table.table_id}`"
    use_legacy_sql = false
  }
  depends_on = [google_bigquery_table.terra_table]
}
