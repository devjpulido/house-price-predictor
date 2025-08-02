variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
}

variable "ssh_key_name" {
  description = "The name of the SSH key in DigitalOcean"
  type        = string
}

variable "droplet_count" {
  description = "Number of droplets to create"
  type        = number
  default     = 1
}


variable "droplet_name" {
  description = "Name of the Droplet"
  type        = string
  default     = "my-droplet"
}

variable "vpc_name" {
  description = "Name of the VPC to create"
  type        = string
  default     = "default-vpc"
  
}

variable "region" {
  description = "Region to create the Droplet"
  type        = string
  default     = "nyc3"
}

variable "size" {
  description = "Droplet size"
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "image" {
  description = "OS image to use for the Droplet"
  type        = string
  default     = "ubuntu-24-04-x64"
}