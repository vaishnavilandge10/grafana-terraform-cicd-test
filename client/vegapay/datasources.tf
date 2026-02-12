data "grafana_data_source" "datasources" {
  for_each = var.datasources
  name     = each.key
}

locals {
  datasource_uids = {
    for k, v in data.grafana_data_source.datasources : k => v.uid
  }
}