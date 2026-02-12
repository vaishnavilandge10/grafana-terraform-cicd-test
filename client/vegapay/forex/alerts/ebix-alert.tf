resource "grafana_rule_group" "ebix_alerts" {
  name             = "10s alerts"
  folder_uid       = var.folder_uid
  interval_seconds = 10
  disable_provenance = true

  rule {
    name      = "HTTP Request Rate"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }
      datasource_uid = var.datasource_uid
      model          = "{\"datasource\":{\"type\":\"prometheus\",\"uid\":\"${var.datasource_uid}\"},\"disableTextWrap\":false,\"editorMode\":\"builder\",\"expr\":\"group by(app) (rate(http_server_requests_seconds_count{kubernetes_namespace=\\\"default\\\"}[$__rate_interval]))\",\"format\":\"time_series\",\"fullMetaSearch\":false,\"includeNullMetadata\":true,\"instant\":false,\"interval\":\"\",\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":true,\"refId\":\"A\",\"useBackend\":false}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"B\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"reducer\":\"last\",\"refId\":\"B\",\"type\":\"reduce\"}"
    }
    data {
      ref_id = "C"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[20],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\",\"unloadEvaluator\":{\"params\":[15],\"type\":\"lt\"}}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"B\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"C\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "10s"
    annotations = {
      description = ""
      runbook_url = ""
      summary     = ""
    }
    labels = {
      backend = "backend"
    }
    is_paused = false

    notification_settings {
      contact_point = "vegapay-prod-zenduty"
      group_by      = null
      mute_timings  = []
    }
  }
  rule {
    name      = "HTTP 500 Error Rate"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"datasource\":{\"type\":\"prometheus\",\"uid\":\"${var.datasource_uid}\"},\"disableTextWrap\":false,\"editorMode\":\"builder\",\"expr\":\"group by(app) (rate(http_server_requests_seconds_count{kubernetes_namespace=\\\"default\\\", status=\\\"500\\\"}[$__rate_interval]))\",\"fullMetaSearch\":false,\"hide\":false,\"includeNullMetadata\":false,\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\",\"useBackend\":false}"
    }
    data {
      ref_id = "C"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[5],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\",\"unloadEvaluator\":{\"params\":[3],\"type\":\"lt\"}}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"C\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "10s"
    labels = {
      backend = "backend"
    }
    is_paused = false

    notification_settings {
      contact_point = "vegapay-prod-zenduty"
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "Forex-Transaction Too Many Requests Warning"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"datasource\":{\"type\":\"prometheus\",\"uid\":\"${var.datasource_uid}\"},\"disableTextWrap\":false,\"editorMode\":\"builder\",\"expr\":\"sum by(app) (rate(http_server_requests_seconds_count{kubernetes_namespace=~\\\"default\\\", app=\\\"forex-transaction\\\"}[1m]))\",\"fullMetaSearch\":false,\"includeNullMetadata\":true,\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\",\"useBackend\":false}"
    }
    data {
      ref_id = "C"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[15],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\",\"unloadEvaluator\":{\"params\":[12],\"type\":\"lt\"}}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"C\",\"type\":\"threshold\"}"
    }

    no_data_state  = "OK"
    exec_err_state = "OK"
    for            = "1m"
    is_paused      = false

    notification_settings {
      contact_point = "vegapay-prod-zenduty"
      group_by      = null
      mute_timings  = null
    }
  }
  rule {
    name      = "Forex Transaction Threshold Alert Warning - 800ms"
    condition = "C"

    data {
      ref_id = "A"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = var.datasource_uid
      model          = "{\"datasource\":{\"type\":\"prometheus\",\"uid\":\"${var.datasource_uid}\"},\"disableTextWrap\":false,\"editorMode\":\"builder\",\"expr\":\"sum(irate(http_server_requests_seconds_sum{kubernetes_namespace=\\\"default\\\", method=\\\"POST\\\"}[$Interval])) / sum(irate(http_server_requests_seconds_count{app=~\\\"$Application\\\", uri=~\\\"$URI\\\", method=~\\\"$Method\\\"}[$Interval]))\",\"fullMetaSearch\":false,\"hide\":false,\"includeNullMetadata\":true,\"instant\":true,\"intervalMs\":1000,\"legendFormat\":\"__auto\",\"maxDataPoints\":43200,\"range\":false,\"refId\":\"A\",\"useBackend\":false}"
    }
    data {
      ref_id = "B"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"B\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"A\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"reducer\":\"last\",\"refId\":\"B\",\"type\":\"reduce\"}"
    }
    data {
      ref_id = "C"

      relative_time_range {
        from = 600
        to   = 0
      }

      datasource_uid = "__expr__"
      model          = "{\"conditions\":[{\"evaluator\":{\"params\":[0],\"type\":\"gt\"},\"operator\":{\"type\":\"and\"},\"query\":{\"params\":[\"C\"]},\"reducer\":{\"params\":[],\"type\":\"last\"},\"type\":\"query\"}],\"datasource\":{\"type\":\"__expr__\",\"uid\":\"__expr__\"},\"expression\":\"B\",\"intervalMs\":1000,\"maxDataPoints\":43200,\"refId\":\"C\",\"type\":\"threshold\"}"
    }

    no_data_state  = "NoData"
    exec_err_state = "Error"
    for            = "1m"
    is_paused      = true

    notification_settings {
      contact_point = "vegapay-prod-zenduty"
      group_by      = null
      mute_timings  = null
    }
  }
}
