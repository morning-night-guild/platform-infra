provider "upstash" {
  email   = data.sops_file.upstash_email.data["data"]
  api_key = data.sops_file.upstash_api_key.data["data"]
}

resource "upstash_redis_database" "redis" {
  database_name = var.name
  region        = var.cloud_provider_region
  tls           = "true"
}

data "upstash_redis_database_data" "redis_data" {
  database_id = resource.upstash_redis_database.redis.database_id
}
