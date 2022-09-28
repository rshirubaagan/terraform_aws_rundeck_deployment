# global variables

# CIDR block
variable "vpc_cidr_block" {
  description = "vpc variable"
  type        = string
  default     = "10.20.0.0/16"
}

# default AWS region
variable "region" {
  default = "eu-north-1"
}

# availability zone
variable "zone_a" {
  default = "eu-north-1a"
}
