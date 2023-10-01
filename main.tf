terraform {
  cloud {
    organization = "wedgg"

    workspaces {
      name = "terra-house-1"
    }
  }
}

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
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "example" {
  # Bucket naming rules
  # https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
  bucket = random_string.bucket_name.result
}
resource "random_string" "bucket_name" {
  lower           = true
  length           = 32
  special          = false
  upper = false
  min_numeric = 3
}
output "random_bucket_name" {
    value = random_string.bucket_name.result
}
# Thi
# This is my first change!

# This is my second change!
