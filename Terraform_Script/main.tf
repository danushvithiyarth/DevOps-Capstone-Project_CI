provider "aws" {
  region = "eu-north-1"
}


module "module" {
  source = "./Module"
}
