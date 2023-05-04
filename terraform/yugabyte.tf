provider "ybm" {
  host            = "cloud.yugabyte.com"
  use_secure_host = false
  auth_token      = data.sops_file.yugabyte_auth_token.data["data"]
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
    password = data.sops_file.yugabyte_sql_user_password.data["data"]
  }
}
