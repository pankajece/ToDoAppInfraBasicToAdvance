variable "virtual_network_name" {
    type = string
  description = "virtual network name"
}

variable "virtual_network_location" {
  type = string
  default = "virtual network locaiton"
}

variable "resource_group_name" {
  type = string
  default = "virtual network resource group name"
}

variable "address_space" {
  type = list(string)
  description = "address spacess"
}