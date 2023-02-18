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

resource "vercel_project" "vercel_project" {
  name          = "${var.env}-morning-night-guild-platform-web"
  framework     = "vite"
  team_id       = var.vercel_team_id
  build_command = "yarn build"
  git_repository = {
    type              = "github"
    repo              = var.github_repository
    production_branch = "main"
  }
}

resource "vercel_project_environment_variable" "appapi_endpoint" {
  project_id = vercel_project.vercel_project.id
  team_id    = var.vercel_team_id
  key        = "VITE_SERVICE_ENDPOINT"
  value      = var.appapi_endpoint
  target     = ["production"]
}
