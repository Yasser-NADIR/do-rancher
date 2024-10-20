# Configure the DigitalOcean Provider
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_ssh_key" "default" {
  name       = "ssh_root_key"
  public_key = file("id_rsa.pub")
}

resource "digitalocean_droplet" "node" {
  image  = "centos-stream-9-x64"
  name   = "rke2-node"
  region = "nyc3"
  size   = "s-2vcpu-4gb"
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
}

resource "local_file" "ansible_inventory" {
  content = <<-DOC
    [rke2_nodes]
    ${digitalocean_droplet.node.ipv4_address} ansible_user=root
    DOC
  filename = "${path.module}/inventory.ini"
}