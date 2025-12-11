variable "resource_group_name" {
  description = "Nom du groupe de ressources"
  type        = string
  default     = "rg-terraform-demo"
}

variable "location" {
  description = "Région Azure"
  type        = string
  default     = "norwayeast"
}

variable "vm_name" {
  description = "Nom de la machine virtuelle"
  type        = string
  default     = "vm-linux-apache"
}

variable "vm_size" {
  description = "Taille de la VM (Azure Student a des limites)"
  type        = string
  default     = "Standard_B2s_v2"
}

variable "admin_username" {
  description = "Nom d'utilisateur administrateur"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Mot de passe administrateur"
  type        = string
  default     = "P@ssw0rd1234!"
  sensitive   = true
}