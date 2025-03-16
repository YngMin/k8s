terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket         = "yngmin-k8s-dev-tfstate"
    key            = "terraform/environments/dev/vpc/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "terraform-k8s-lock-dev"
  }
}
