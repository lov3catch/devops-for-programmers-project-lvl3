terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "botonarioum"

    workspaces {
      prefix = "hexlet-"
    }
  }
}