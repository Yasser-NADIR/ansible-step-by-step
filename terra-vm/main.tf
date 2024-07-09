terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_ssh_key" "default" {
  name       = "mac_pub_key"
  public_key = file("id_rsa.pub")
}

resource "digitalocean_droplet" "vm" {
  image  = "centos-stream-9-x64"
  name   = "vm"
  region = "fra1"
  size   = "s-2vcpu-2gb"
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
}

output "vm_ip" {
  value = digitalocean_droplet.vm.ipv4_address
}