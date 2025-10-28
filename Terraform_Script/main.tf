provider "aws" {
  region = "eu-north-1"
}


module "module" {
  source = "./Modules"
}
