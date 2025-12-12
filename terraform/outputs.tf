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
  value       = "ssh -i ${var.ssh_key_path}/${var.ssh_key_name} ${var.admin_username}@${azurerm_public_ip.main.ip_address}"
}

output "vm_name" {
  description = "Nom de la machine virtuelle"
  value       = azurerm_linux_virtual_machine.main.name
}

output "key_vault_name" {
  description = "Nom du Key Vault contenant la clé SSH privée"
  value       = azurerm_key_vault.main.name
}

output "key_vault_secret_id" {
  description = "ID du secret contenant la clé SSH privée"
  value       = azurerm_key_vault_secret.ssh_private_key.id
  sensitive   = true
}

output "ssh_key_generated" {
  description = "Confirmation que la clé SSH a été générée"
  value       = "Clé SSH générée automatiquement dans ${var.ssh_key_path}/${var.ssh_key_name}"
}

output "ssh_key_in_vault" {
  description = "Confirmation du stockage de la clé dans Key Vault"
  value       = "Clé privée SSH stockée de manière sécurisée dans Azure Key Vault: ${azurerm_key_vault.main.name}"
}

output "ssh_private_key_path" {
  description = "Chemin vers la clé privée SSH locale"
  value       = pathexpand("${var.ssh_key_path}/${var.ssh_key_name}")
}

output "admin_username" {
  description = "Nom d'utilisateur administrateur"
  value       = var.admin_username
}
