resource "grafana_folder" "forex_account" {
  title = "Forex Account"
}

resource "grafana_dashboard" "forex_account" {
  for_each = fileset("${path.module}/dashboards", "*.json")

  folder      = grafana_folder.forex_account.id
  config_json = templatefile("${path.module}/dashboards/${each.value}", {
    datasource_uid = lookup(var.datasource_uids, "Prometheus", "")
  })
}

module "alerts" {
  source = "./alerts"

  providers = {
    grafana = grafana
  }

  folder_uid     = grafana_folder.forex_account.uid
  datasource_uid = lookup(var.datasource_uids, "prometheus", "")
}

