resource "azurerm_network_interface" "nic" {
  name                = "pan-nic"
  location            = "centralindia"
  resource_group_name =  "rg-pankaj"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "/subscriptions/76b4b0cd-299a-4d66-9c1f-e53b1131a9f0/resourceGroups/RG-Logic-App/providers/Microsoft.Network/virtualNetworks/pankaj_vnet/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "pi" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "pankaj-vm"
  resource_group_name = "rg-pankaj"
  location            = "centralindia"
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}