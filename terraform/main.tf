resource "digitalocean_droplet" "web" {
  count    = 2
  image    = "ubuntu-18-04-x64"
  name     = "web-${count.index}"
  region   = "ams3"
  size     = "s-1vcpu-1gb"
  ssh_keys = [data.digitalocean_ssh_key.my_ssh.id]
}

data "digitalocean_ssh_key" "my_ssh" {
  name = "macbook"
}

resource "digitalocean_certificate" "cert" {
  name    = "le-terraform-cert"
  type    = "lets_encrypt"
  domains = ["botonarioum.one"]
}

resource "digitalocean_loadbalancer" "balancer" {
  name   = "balancer"
  region = "ams3"
  forwarding_rule {
    entry_port       = 80
    entry_protocol   = "http"
    target_port      = 80
    target_protocol  = "http"
    certificate_name = digitalocean_certificate.cert.name
  }

  droplet_ids = digitalocean_droplet.web.*.id
}

resource "digitalocean_database_cluster" "db-cluster" {
  engine     = "pg"
  version    = "12"
  name       = "botonarioum-db-cluster"
  node_count = 1
  region     = "ams3"
  size       = "db-s-1vcpu-1gb"
}

resource "digitalocean_database_db" "db-redmine" {
  cluster_id = digitalocean_database_cluster.db-cluster.id
  name       = "redmine"
}

output "db" {
  value = {
    "droplets" : digitalocean_droplet.web.*.ipv4_address
  }
}