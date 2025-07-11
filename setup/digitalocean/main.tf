# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MIT

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

# Use the name you set in DigitalOcean for the SSH key
data "digitalocean_ssh_key" "default" {
  name = var.ssh_key_name 
}

# Create a VPC (Virtual Private Cloud)
# This is optional but recommended for better network isolation
resource "digitalocean_vpc" "vpc" {
  name   = var.vpc_name
  region = var.region
}

# Create the Droplet
# This will create multiple droplets based on the count variable
resource "digitalocean_droplet" "server" {
  image     = var.image
  name      = "${var.droplet_name}${count.index + 1}"
  region    = var.region
  size      = var.size
  count     = var.droplet_count
  #user_data = file("setup.sh")
  vpc_uuid  = digitalocean_vpc.vpc.id
  ssh_keys = [data.digitalocean_ssh_key.default.fingerprint]

  # Timeouts for creating, updating, and deleting the droplet
  timeouts {
    create = "10m"
    update = "10m"
    delete = "15m"
  }

}