# vegapay/variables.tf

# Grafana URL
variable "grafana_url" {
  description = "The URL of the Grafana instance"
  type        = string
}

# Grafana API Key (sensitive)
variable "grafana_auth" {
  description = "API key or basic auth for Grafana"
  type        = string
  sensitive   = true
}

# Environment name (dev, staging, prod)
variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

# List of services to deploy (forex, wallet, alerts, etc.)
variable "enabled_services" {
  description = "List of services to deploy"
  type        = list(string)
  default     = ["forex"]
}

# Client name (unity, ssfb, bob, etc.)
variable "client" {
  description = "Client for client-specific deployment"
  type        = string
}

# Names of existing datasources to reference
variable "datasources" {
  description = "Names of existing datasources to reference in Grafana"
  type        = set(string)
  default     = ["prometheus"]
}
