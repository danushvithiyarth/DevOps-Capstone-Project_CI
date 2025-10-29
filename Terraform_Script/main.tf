terraform {
  backend "s3" {
    bucket = "danushvithiyarthjaiganesh"
    key    = "terraform-capstoneproject.tf"
    region = "eu-north-1"
  }
}

provider "aws" {
  region = "eu-north-1"
}


module "module" {
  source = "./Modules"
}
