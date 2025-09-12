variable "project_name" {
  default = "logo-server"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Project = "logo-server"
    Environment = "dev"
    Terraform = "true"
    Component = "ingress-alb"
  }
}

variable "zone_name" {
  default = "prasadbeedam.shop"
}

variable "zone_id" {
  default = "Z0076662RSBAVK1BRCBD"
}