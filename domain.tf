resource "cloudflare_record" "recordA" {
  zone_id = var.cf_wlodek_net_zone_id
  name    = var.sub_domain
  type    = "A"
  content = data.kubernetes_service.postgresql_service.status[0].load_balancer[0].ingress[0].ip
}

resource "cloudflare_record" "recordCNAME" {
  zone_id = var.cf_wlodek_net_zone_id
  name    = "www.${var.sub_domain}"
  type    = "CNAME"
  content = cloudflare_record.recordA.hostname
}
