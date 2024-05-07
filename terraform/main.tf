terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "0.7.2"
    }
    cockroach = {
      source  = "cockroachdb/cockroach"
      version = "0.2.0"
    }
    ybm = {
      source  = "yugabyte/ybm"
      version = "1.0.21"
    }
    upstash = {
      source  = "upstash/upstash"
      version = "1.4.0"
    }
  }
}
