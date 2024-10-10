terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "0.7.2"
    }
    cockroach = {
      source  = "cockroachdb/cockroach"
      version = "1.9.0"
    }
    ybm = {
      source  = "yugabyte/ybm"
      version = "1.0.4"
    }
    upstash = {
      source  = "upstash/upstash"
      version = "1.4.0"
    }
  }
}
