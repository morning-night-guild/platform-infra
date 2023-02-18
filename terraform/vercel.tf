variable "vercel_api_token" {
  type      = string
  nullable  = false
  sensitive = true
}

variable "github_repository" {
  type     = string
  nullable = false
}

variable "appapi_endpoint" {
  type     = string
  nullable = false
}

variable "vercel_team_id" {
  type     = string
  nullable = false
}

provider "vercel" {
  api_token = var.vercel_api_token
}
