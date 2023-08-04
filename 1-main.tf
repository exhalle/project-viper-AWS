provider "aws" {
  shared_credentials_files = var.pathtocred
  region                   = var.region
  profile                  = var.profile
}