variable "service_principal" {
  type = object({
    client_id       = string
    client_secret   = string
    tenant_id       = string
    subscription_id = string
  })
}

variable "location" {
  type = string
}
variable "environment" {
  type = string
}
variable "address_space" {
  type = string
}

variable "ssh_key_filepath" {
  type = string
}