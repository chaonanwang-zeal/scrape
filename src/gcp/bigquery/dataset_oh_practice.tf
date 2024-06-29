resource "google_bigquery_table" "terra_table" {
  deletion_protection = false
  dataset_id          = "oh_practice"
  table_id            = "terra_table"
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
      type = "STRING"
    },
    {
      name = "column4",
      type = "STRING"
    }
  ])
}


