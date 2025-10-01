module "resource_group" {
  source = "../modules/azurerm_resource_group"
  resource_group_name = "rg-todoapp"
  resource_group_location = "Japan East"
}

module "virtual_network" {
  source = "../modules/azurerm_virtual_network"
  virtual_network_name = "vnet-todoapp"
  virtual_network_location = "Japan East"
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

# module "backend_subnet" {
#   source = "../modules/azurerm_subnet"
#   subnet_name = "backemd-subnet"
#   resouce_group_name = "rg-todoapp"
#   virtual_network_name = "vnet-todoapp"
#   address_prefixes = ["10.0.2.0/24"]
#   depends_on = [ module.virtual_network ]
# }

module "public_ip_frontend" {
  source = "../modules/azurerm_public_ip"
  pan_public_ip_name = "todo-public-ip-frontend"
  resource_group_name = "rg-todoapp"
  location = "Japan East"
  allocation_method = "Static"
  depends_on = [ module.resource_group ]
}

# module "public_ip_backend" {
#   source = "../modules/azurerm_public_ip"
#   pan_public_ip_name = "todo-public-ip-backend"
#   resource_group_name = "rg-todoapp"
#   location = "Japan East"
#   allocation_method = "Static"
#   depends_on = [ module.resource_group ]
# }

module "frontend_vm" {
  source = "../modules/azurerm_virtual_machine"

  depends_on = [ module.frontend_subnet , module.keyvault, module.keyvault_secret_user_id, module.keyvault_secret_password,module.public_ip_frontend]

//for nic resource
  nic_name = "frontend_nic"
  
//common in both resouce
  resource_group_name = "rg-todoapp"
  location = "Japan East"

//for virtual machine
  vm_name = "vmfrontend"
  vm_size = "Standard_D2s_v3"
  
  image_publisher = "Canonical"
  image_offer = "0001-com-ubuntu-server-focal"
  image_sku = "20_04-lts"
  image_version = "latest"

  
  virtual_network_name = "vnet-todoapp"
  subnet_name = "fontend-subnet"
  pip_name = "todo-public-ip-frontend"

  kev_vault_name = "todo-new-keyvalut"
  kv_secret_vm_user_id = "vm-user-id"
  kv_secret_vm_password = "vm-password"

}

# module "backend_vm" {
#   source = "../modules/azurerm_virtual_machine"

#   //for nic resouce
#   nic_name = "backend_nic"
  

#   //common in resource
#   resource_group_name = "rg-todoapp"
#   location = "Japan East"
  
  
#   vm_name = "vm-backend"
#   vm_size = "Standard_D2s_v3"
  
#   image_publisher = "Canonical"
#   image_offer = "0001-com-ubuntu-server-focal"
#   image_sku = "20_04-lts"
#   image_version = "latest"
#   depends_on = [ module.backend_subnet ]
#   virtual_network_name = "vnet-todoapp"
#   subnet_name = "backemd-subnet"
#   pip_name = "todo-public-ip-backend"

# }

module "sql_server" {
  source = "../modules/azurerm_sql_server"
  sql_server_name = "sqlservertodoapp"
  resource_group_name = "rg-todoapp"
  location = "Japan East"
  administrator_login = "sqlServerAdmin"
  administrator_login_password = "Pankaj@6220"
  depends_on = [ module.resource_group ]
}

module "sql_db" {
  source = "../modules/azurerm_sql_database"
  sql_database_name = "todo-sql-db"
  sql_server_name = "sqlservertodoapp"
  resouce_group_name = "rg-todoapp"
  depends_on = [ module.sql_server ]
}

module "keyvault" {
  source = "../modules/azurerm_key_vault"
  depends_on = [ module.resource_group ]
  todo_key_vault_name = "todo-new-keyvalut"
  location = "Japan East"
  resouce_group_name = "rg-todoapp"
}

module "keyvault_secret_user_id" {
  source = "../modules/azurerm_key_vault_secret"
  secret_name = "vm-user-id"
  secret_value = "todo-vm-machine-front"
  key_vault_name = "todo-new-keyvalut"
  resouce_group_name = "rg-todoapp"
  depends_on = [ module.keyvault ]
}

module "keyvault_secret_password" {
  source = "../modules/azurerm_key_vault_secret"
  secret_name = "vm-password"
  secret_value = "PankajTodoVM12"
  key_vault_name = "todo-new-keyvalut"
  resouce_group_name = "rg-todoapp"
  depends_on = [ module.keyvault ]
}

//test comment
//commetn from live
//at line 156 added by live
