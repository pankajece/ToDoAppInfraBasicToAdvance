data "azurerm_mssql_server" "sql_Server" {
  name                = var.sql_server_name
  resource_group_name = var.resouce_group_name
}