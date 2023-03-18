variable "yugabyte_auth_token" {
  description = "The authentication token."
  type        = string
  nullable    = false
  sensitive   = true
}

variable "yugabyte_sql_user_password" {
  type      = string
  nullable  = false
  sensitive = true
}

provider "ybm" {
  host            = "cloud.yugabyte.com"
  use_secure_host = false
  auth_token      = var.yugabyte_auth_token
}

resource "ybm_allow_list" "ybm_allow_list" {
  allow_list_name        = "allow-all"
  allow_list_description = "allow all the ip addresses"
  cidr_list              = ["0.0.0.0/0"]
}

resource "ybm_cluster" "single_region_cluster" {
  cluster_name = var.name
  cloud_type   = var.cloud_provider
  cluster_type = "SYNCHRONOUS"
  cluster_region_info = [
    {
      region    = var.cloud_provider_region
      num_nodes = 1
    }
  ]
  cluster_tier           = "FREE"
  cluster_allow_list_ids = [ybm_allow_list.ybm_allow_list.allow_list_id]
  fault_tolerance        = "NONE"
  node_config = {
    num_cores = 2
  }
  credentials = {
    username = var.name
    password = var.yugabyte_sql_user_password
  }
}
