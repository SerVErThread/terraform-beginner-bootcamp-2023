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
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
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