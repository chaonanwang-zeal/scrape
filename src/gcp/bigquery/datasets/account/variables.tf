variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "Region for the GCP resources"
  type        = string
}

variable "module_source" {
  default = "src/gcp/bigquery/modules/bigquery_table"
}