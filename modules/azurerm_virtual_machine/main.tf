


resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     =  data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = data.azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "pan_vm" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = data.azurerm_key_vault_secret.vm-username.value
  admin_password = data.azurerm_key_vault_secret.vm_password.value
  disable_password_authentication =false
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  # admin_ssh_key {
  #   username   = "adminuser"
  #   public_key = file("~/.ssh/id_rsa.pub")
  # }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher  # publish id From microsoft market place
    offer     = var.image_offer  # offer id form market plance 
    sku       = var.image_sku # plan id form makret plance 
    version   = var.image_version 
  }

  custom_data = base64encode(<<-EOF
     #!/bin/bash
     apt-get update
     apt-get install -y nginx
     systemctl start nginx
     systemctl enable nginx
     echo "<h1>Welcome to Nginx via Terraform!</h1>" | sudo tee /var/www/html/index.html
  EOF
  )
}

