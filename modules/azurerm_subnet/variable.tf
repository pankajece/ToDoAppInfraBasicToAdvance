variable "subnet_name" {
    type = string
    description = "subnet name"
}

variable "resouce_group_name" {
  type = string
  description = "resource group name"
}

variable "virtual_network_name" {
  type = string
  description = "name of virtual network where subenet will"
}

variable "address_prefixes" {
  type = list(string)
  description = "address spaces"
}