variable "upstash_email" {
  type      = string
  nullable  = false
  sensitive = true
}

variable "upstash_api_key" {
  type      = string
  nullable  = false
  sensitive = true
}

provider "upstash" {
  email   = var.upstash_email
  api_key = var.upstash_api_key
}

resource "upstash_redis_database" "redis" {
  database_name = var.name
  region        = var.cloud_provider_region
  tls           = "true"
}

data "upstash_redis_database_data" "redis_data" {
  database_id = resource.upstash_redis_database.redis.database_id
}
