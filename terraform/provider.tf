terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

provider "datadog" {
  api_key = var.dd_api_key
  app_key = var.dd_app_key
}

variable "do_token" {
  description = "Digital ocean token"
  type        = string
}

variable "dd_api_key" {
  description = "DD app key"
  type        = string
}

variable "dd_app_key" {
  description = "DD api key"
  type        = string
}
