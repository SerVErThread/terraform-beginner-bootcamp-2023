terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "random" {
  # Configuration options
}

resource "random_string" "bucket-name" {
  length           = 16
  special          = false
}




output "random_bucket_name" {
    value = random_string.bucket-name.result
}
# Thi
# This is my first change!

# This is my second change!
