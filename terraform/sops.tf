provider "sops" {}

data "sops_file" "cockroach_api_key" {
  source_file = "sops/cockroach-api-key.enc.json"
}

data "sops_file" "cockroach_sql_user_password" {
  source_file = "sops/cockroach-sql-user-password.enc.json"
}

data "sops_file" "yugabyte_auth_token" {
  source_file = "sops/yugabyte-auth-token.enc.json"
}

data "sops_file" "yugabyte_sql_user_password" {
  source_file = "sops/yugabyte-sql-user-password.enc.json"
}

data "sops_file" "upstash_email" {
  source_file = "sops/upstash-email.enc.json"
}

data "sops_file" "upstash_api_key" {
  source_file = "sops/upstash-api-key.enc.json"
}
