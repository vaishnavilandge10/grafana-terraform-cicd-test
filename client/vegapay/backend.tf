terraform {
  backend "s3" {
    bucket         = "grafana-terraform-state-vegapay"
    key            = "vegapay/prod/grafana/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
