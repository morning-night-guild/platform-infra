variable "name" {
  type     = string
  nullable = false
  default  = "platform"
}

variable "cloud_provider" {
  type     = string
  nullable = false
  default  = "GCP"
}

variable "cloud_provider_region" {
  type     = string
  nullable = false
  default  = "us-central1"
}

variable "cloud_provider_regions" {
  type     = list(string)
  nullable = false
  default  = ["us-central1"]
}
