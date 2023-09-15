locals {
  suffix                 = length(var.suffix) == 0 ? "" : "-${var.suffix}"
  virtual_machine_name   = var.custom_virtual_machine_name == null ? "vm-${var.env}${local.suffix}" : "${var.custom_virtual_machine_name}${local.suffix}"
  network_interface_name = var.custom_network_interface_name == null ? "nic-${var.project}-${var.env}-${var.location}${local.suffix}" : "${var.custom_network_interface_name}${local.suffix}"
  public_ip              = var.custom_public_ip_name == null ? "ip-${var.project}-${var.env}-${var.location}${local.suffix}" : "${var.custom_public_ip_name}${local.suffix}"
}

resource "azurerm_public_ip" "this" {
  count = var.public_ip_enabled ? 1 : 0

  name                = local.public_ip
  resource_group_name = var.resource_group
  location            = var.location
  allocation_method   = var.public_ip_allocation_method
}

resource "azurerm_network_interface" "this" {
  name                = local.network_interface_name
  location            = var.location
  resource_group_name = var.resource_group
  tags                = var.tags

  ip_configuration {
    name                          = "ip-config-${var.project}-${var.env}-${var.location}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.network_interface_private_ip_address_allocation
    public_ip_address_id          = try(azurerm_public_ip.this[0].id, null)
  }
}

resource "azurerm_windows_virtual_machine" "this" {
  name                  = local.virtual_machine_name
  location              = var.location
  resource_group_name   = var.resource_group
  network_interface_ids = [azurerm_network_interface.this.id]
  size                  = var.vm_size
  admin_username        = var.vm_admin_username
  admin_password        = var.vm_admin_password

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
  }

  dynamic "identity" {
    for_each = var.identity_enabled ? [1] : []

    content {
      type = "SystemAssigned"
    }
  }
}
