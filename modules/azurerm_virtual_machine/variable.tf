variable "nic_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}



variable "vm_name" {
  type = string
}

variable "vm_size" {
  type = string
}
variable "admin_username" {
  type = string
}

variable "admin_password" {
  type = string
}

variable "image_publisher" {
  type = string
}

variable "image_offer" {
  type = string
}

variable "image_sku" {
  type = string
}
variable "image_version" {
  type = string
}


variable "subnet_name" {
  type = string
  
}

variable "virtual_network_name" {
  type = string
}
variable "pip_name" {
  type = string
}