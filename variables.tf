variable "ovh_service_name" {
  description = "Service name of OVH Public Cloud project"
  type        = string
  sensitive   = true
}

variable "cf_api_token" {
  description = "Cloudflare API Token"
  type        = string
  sensitive   = true
}

variable "cf_wlodek_net_zone_id" {
  description = "Zone ID"
  type        = string
  sensitive   = true
}

variable "sub_domain" {
  type    = string
  default = "postgresql"
}
