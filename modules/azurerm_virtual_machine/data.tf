data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}


data "azurerm_public_ip" "public_ip" {
  name                = var.pip_name
  resource_group_name = var.resource_group_name
}


data "azurerm_key_vault" "kv" {
  name                = "testKeyvalut01"
  resource_group_name = "RG-Logic-App"
}


data "azurerm_key_vault_secret" "vm_password" {
    name = "frontend-vm-password"
    key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "vm-username" {
    name = "vm-username"
    key_vault_id = data.azurerm_key_vault.kv.id
}