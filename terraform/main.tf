module "aws" {
  source = "./aws"
}

module "azure" {
  source = "./azure"
}

module "gcp" {
  source = "./gcp"
  gcp_service_account_key = var.gcp_service_account_key
}