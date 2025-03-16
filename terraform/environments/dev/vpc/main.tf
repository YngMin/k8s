module "vpc" {
  source       = "../../../module/vpc"
  account_name = var.account_name
  cidr_numeral = var.cidr_numeral
  environment  = var.environment
}
