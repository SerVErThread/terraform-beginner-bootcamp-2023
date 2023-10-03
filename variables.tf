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
