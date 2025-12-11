terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  # Pour un compte Azure Student, pas besoin de subscription_id explicite
  # Azure CLI gère l'authentification automatiquement
}