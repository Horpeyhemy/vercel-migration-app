variable "resource_group_name" {
  type    = string
  default = "vercel-migration-rg"
}

variable "location" {
  type    = string
  default = "East US"
}

variable "app_service_plan_name" {
  type    = string
  default = "vercel-migration-plan"
}

variable "web_app_name" {
  type    = string
  default = "vercel-migration-app"
}

variable "vnet_name" {
  type    = string
  default = "vercel-migration-vnet"
}

variable "subnet_name" {
  type    = string
  default = "vercel-migration-subnet"
}

variable "database_url" {
  type        = string
  description = "Vercel Postgres database URL"
}
