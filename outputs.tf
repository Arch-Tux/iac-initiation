output "resource_group_name" {
  description = "Nom du groupe de ressources"
  value       = azurerm_resource_group.main.name
}

output "public_ip_address" {
  description = "Adresse IP publique de la VM"
  value       = azurerm_public_ip.main.ip_address
}

output "apache_url" {
  description = "URL du serveur Apache"
  value       = "http://${azurerm_public_ip.main.ip_address}"
}

output "ssh_connection" {
  description = "Commande de connexion SSH"
  value       = "ssh ${var.admin_username}@${azurerm_public_ip.main.ip_address}"
}

output "vm_name" {
  description = "Nom de la machine virtuelle"
  value       = azurerm_linux_virtual_machine.main.name
}
