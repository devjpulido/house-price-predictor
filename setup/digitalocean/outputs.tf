output "droplet_ips" {
  description = "List of Public IP addresses of created Droplets"
  value       = digitalocean_droplet.server[*].ipv4_address
}


output "droplet_ids" {
  description = "List of Public IP addresses of created Droplets"
  value       = digitalocean_droplet.server[*].id
}