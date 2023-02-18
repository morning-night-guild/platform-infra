terraform {
  required_providers {
    cockroach = {
      source  = "cockroachdb/cockroach"
      version = "0.2.0"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "0.11.4"
    }
  }
}
