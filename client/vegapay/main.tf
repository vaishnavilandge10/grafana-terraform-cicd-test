# client/vegapay/main.tf
module "forex" {
  source = "./forex"
  count  = contains(var.enabled_services, "forex") ? 1 : 0

  providers = {
    grafana = grafana
  }

  datasource_uids = local.datasource_uids
  # contact_point_name = "default-contact-point"
}

# module "wallet" {
#   source = "./wallet"
#   count  = contains(var.enabled_services, "wallet") ? 1 : 0
#
#   environment        = var.environment
#   datasource_uids    = local.datasource_uids
#   contact_point_name = "default-contact-point"
# }
#
# module "transaction" {
#   source = "./transaction"
#   count  = contains(var.enabled_services, "transaction") ? 1 : 0
#
#   environment        = var.environment
#   datasource_uids    = local.datasource_uids
#   contact_point_name = "default-contact-point"
# }
