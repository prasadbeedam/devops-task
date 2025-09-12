variable "common_tags" {
  default = {
    Project     = "logo-server"
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "sg_tags" {
  default = {}
}

variable "project_name" {
  default = "logo-server"
}
variable "environment" {
  default = "dev"
}

variable "cluster_service_ipv4_cidr" {
  default = "10.100.0.0/16"
}