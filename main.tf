#terraform {
#  cloud {
#    organization = "wedgg"
#
#    workspaces {
#      name = "terra-house-1"
#    }
#  }
#}



# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
