variable "service_principal" {
  type = object({
    client_id       = string
    client_secret   = string
    tenant_id       = string
    subscription_id = string
  })
}
variable "pip_name" {
  type = string
}
variable "lb_name" {
  type = string
}
variable "vm_name" {
  type = set(string)
}

variable "vnet_name" {
  type = string
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

variable "subnet_external_address_range" {
  type = string

}
variable "subnet_internal_address_range" {
  type = string

}

variable "ssh_key_filepath" {
  type = string
}