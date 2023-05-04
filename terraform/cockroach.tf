variable "cockroach_sql_user_password" {
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
  apikey = data.sops_file.cockroach_api_key.data["data"]
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
  password = data.sops_file.cockroach_sql_user_password.data["data"]
}
