variable "user_uuid" {
  type        = string
  description = "The UUID of the user"
  # Example UUID; replace it with actual UUID when running the code.
  default     = "12345678-abcd-1234-abcd-1234567890ab" 
    validation {
        condition  = can(regex("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$", var.user_uuid))
        error_message = "The user_uuid must be in UUID format: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx where 'x' is a hexadecimal character."
    }
}
variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"

  validation {
    condition     = (
                    length(var.bucket_name) > 2 && 
                    length(var.bucket_name) < 64 && 
                    regex("^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$", var.bucket_name) != null
                    )
    error_message = "Bucket name must be between 3 and 63 characters, and follow AWS bucket naming rules: start and end with a lowercase letter or number, and contain only lowercase letters, numbers, hyphens, and dots."
  }
}

variable "index_html_filepath" {
  type        = string
  description = "The file path for the index.html file"

  validation {
    condition     = fileexists(var.index_html_filepath) 
    error_message = "The index_html_path variable must be a non-empty string and must be an HTML file."
  }
}

variable "error_html_filepath" {
  type        = string
  description = "The file path for the error.html file"

  validation {
    condition     = (
                    length(var.error_html_filepath) > 0 && 
                    regex(".*\\.html$", var.error_html_filepath) != null
                    )
    error_message = "The error_html_path variable must be a non-empty string and must be an HTML file."
  }
}

variable "content_version" {
  type        = number
  description = "Content version should be a positive integer starting at 1."

  validation {
    condition     = var.content_version > 0
    error_message = "The content_version must be a positive integer starting at 1."
  }
}

variable "assets_path" {
  type        = string
  description = "The path to the assets folder"

  validation {
    condition     = fileexists(var.assets_path) 
    error_message = "The assets_path variable must be a non-empty string and must be a folder."
  }
}
