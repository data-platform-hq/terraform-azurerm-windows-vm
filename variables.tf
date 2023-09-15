variable "project" {
  type        = string
  description = "Project name"
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "location" {
  type        = string
  description = "Azure location"
}

variable "resource_group" {
  type        = string
  description = "The name of the resource group"
}

variable "suffix" {
  type        = string
  description = "Optional suffix that would be added to the end of resources names. It is recommended to use dash at the beginning of variable (e.x., '-example')"
  default     = ""
}

variable "custom_virtual_machine_name" {
  type        = string
  description = "Specifies the name of the virtual machine name resource"
  default     = null

  validation {
    condition = (length(var.custom_virtual_machine_name) < 16)
    error_message = "Name should be 15 characters or less"
  }
}

variable "custom_network_interface_name" {
  type        = string
  description = "Specifies the name of the virtual machine interface name resource"
  default     = null
}

variable "custom_public_ip_name" {
  type        = string
  description = "Specifies the name of the public ip name name resource"
  default     = null
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
  default     = {}
}

variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet where this Network Interface should be located in."
}

variable "public_ip_enabled" {
  type        = bool
  description = "Boolean flag to enable Public Ip address creation and assignment to Virtual Machine"
  default     = false
}

variable "public_ip_allocation_method" {
  type        = string
  description = "Defines the allocation method for this IP address. Possible values are Static or Dynamic"
  default     = "Static"
}

variable "network_interface_private_ip_address_allocation" {
  type        = string
  description = "The allocation method used for the Private IP Address."
  default     = "Dynamic"
}

variable "vm_size" {
  type        = string
  description = "The SKU which should be used for this Virtual Machine."
  default     = "Standard_B1s"
}

variable "vm_admin_username" {
  type        = string
  description = "The username of the local administrator used for the Virtual Machine."
  default     = "adminuser"
}

variable "vm_admin_password" {
  type        = string
  description = "The password of the local administrator used for the Virtual Machine."
}

variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
  })
  description = "Objects to configure os disk reference for virtual machine"
  default = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "Objects to configure source image reference for virtual machine"
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter-Core"
    version   = "latest"
  }
}

variable "identity_enabled" {
  type        = bool
  description = "Boolean flag than enables creation of System Assigned identity to VM"
  default     = false
}
