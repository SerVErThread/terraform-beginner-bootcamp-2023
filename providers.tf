#terraform {
#  cloud {
#    organization = "wedgg"
#
#    workspaces {
#      name = "terra-house-1"
#    }
#  }
#}

terraform {
  required_providers {

      aws = {
      source = "hashicorp/aws"
      version = "5.18.1"
    }
  }
}

provider "aws" {
  # Configuration options
}
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
provider "random" {
  # Configuration options
}