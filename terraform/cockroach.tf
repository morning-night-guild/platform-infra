variable "sql_user_password" {
  type      = string
  nullable  = false
  sensitive = true
}

variable "serverless_spend_limit" {
  type     = number
  nullable = false
  default  = 0
}

provider "cockroach" {
  # export COCKROACH_API_KEY with the cockroach cloud API Key
}

resource "cockroach_cluster" "cockroach_db" {
  name           = var.name
  cloud_provider = var.cloud_provider
  serverless = {
    spend_limit = var.serverless_spend_limit
  }
  regions = [for r in var.cloud_provider_regions : { name = r }]
}

resource "cockroach_sql_user" "cockroach_db_user" {
  id       = cockroach_cluster.cockroach_db.id
  name     = var.name
  password = var.sql_user_password
}
