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
  description = "Mot de passe administrateur (OBLIGATOIRE: définir dans terraform.tfvars)"
  type        = string
  sensitive   = true
}

variable "allowed_ssh_ip" {
  description = "IP address allowed to access SSH (OBLIGATOIRE: définir dans terraform.tfvars, qui est gitignore)"
  type        = string
  sensitive = true
}

variable "allowed_http_ip" {
  description = "IP address allowed to access HTTP"
  type        = string
  default     = "*"
}
