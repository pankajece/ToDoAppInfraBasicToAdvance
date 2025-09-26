variable "pan_public_ip_name" {
    description = "public_ip name"
    type = string
}

variable "resource_group_name" {
    description = "pip resouce gr"
    type = string
}

variable "location" {
  description = "location"
  type = string
}

variable "allocation_method" {
  type = string
  description = "allocation method"
}