output "id" {
  value       = azurerm_windows_virtual_machine.this.id
  description = "The ID of the Windows Virtual Machine"
}

output "identity" {
  value       = try(azurerm_windows_virtual_machine.this.identity, [])
  description = "Windows virtual machine Identities list"
}

output "public_ip" {
  value       = try(azurerm_public_ip.this[0].ip_address, null)
  description = "Windows Virtual Machine public IP address"
}

output "private_ip" {
  value       = try(azurerm_windows_virtual_machine.this.private_ip_address, null)
  description = "Windows Virtual Machine private IP address"
}
