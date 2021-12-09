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

resource "digitalocean_record" "dns-record" {
  domain = digitalocean_domain.boto-domain.name
  name   = "@"
  type   = "A"
  value  = digitalocean_loadbalancer.balancer.ip
}

resource "digitalocean_certificate" "lb-cert-boto" {
  name    = "le-terraform-cert-lb"
  type    = "lets_encrypt"
  domains = [digitalocean_domain.boto-domain.name]
}

resource "digitalocean_domain" "boto-domain" {
  name = "botonarioum.one"
}

resource "digitalocean_loadbalancer" "balancer" {
  name   = "balancer"
  region = "ams3"
  forwarding_rule {
    entry_port       = 80
    entry_protocol   = "http"
    target_port      = 80
    target_protocol  = "http"
    certificate_name = digitalocean_certificate.lb-cert-boto.name
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

output "droplet_ips" {
  value = digitalocean_droplet.web.*.ipv4_address
}

output "database" {
  sensitive = true
  value = {
    user     = digitalocean_database_cluster.db-cluster.user
    password = digitalocean_database_cluster.db-cluster.password
    port     = digitalocean_database_cluster.db-cluster.port
    database = digitalocean_database_cluster.db-cluster.database
    host     = digitalocean_database_cluster.db-cluster.host
  }
}

resource "datadog_monitor" "http-check-new" {
  name    = "Http checking new updated"
  type    = "service check"
  message = "Service unavailable"
  query   = "\"datadog.agent.up\".over(\"*\").by(\"host\").last(2).count_by_status()"

  notify_no_data    = true
  renotify_interval = 60
  notify_audit      = false
  timeout_h         = 60
  include_tags      = true
}