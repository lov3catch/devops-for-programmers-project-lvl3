terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "botonarioum"

    workspaces {
      name = "hexlet-homework"
    }
  }
}