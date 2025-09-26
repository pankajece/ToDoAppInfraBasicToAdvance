module "resource_group" {
  source = "../modules/azurerm_resource_group"
  resource_group_name = "rg-todoapp"
  resource_group_location = "centralindia"
}

module "virtual_network" {
  source = "../modules/azurerm_virtual_network"
  virtual_network_name = "vnet-todoapp"
  virtual_network_location = "centralindia"
  resource_group_name = "rg-todoapp"
  address_space = ["10.0.0.0/16"]
  depends_on = [ module.resource_group ]
}

module "frontend_subnet" {
  source = "../modules/azurerm_subnet"
  subnet_name = "fontend-subnet"
  resouce_group_name = "rg-todoapp"
  virtual_network_name = "vnet-todoapp"
  address_prefixes = ["10.0.1.0/24"]
  depends_on = [ module.virtual_network ]
}

module "frontend_backend" {
  source = "../modules/azurerm_subnet"
  subnet_name = "backemd-subnet"
  resouce_group_name = "rg-todoapp"
  virtual_network_name = "vnet-todoapp"
  address_prefixes = ["10.0.2.0/24"]
  depends_on = [ module.virtual_network ]
}

module "public_ip" {
  source = "../modules/azurerm_public_ip"
  pan_public_ip_name = "todo-public-ip"
  resource_group_name = "rg-todoapp"
  location = "centralindia"
  allocation_method = "Static"
}