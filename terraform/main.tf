terraform {
  required_providers {
    cockroach = {
      source  = "cockroachdb/cockroach"
      version = "0.2.0"
    }
    ybm = {
      source  = "yugabyte/ybm"
      version = "1.0.0"
    }
  }
}
