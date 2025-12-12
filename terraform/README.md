# Infrastructure as Code - Déploiement VM Linux avec Apache sur Azure

## Description
Infrastructure déclarative utilisant Terraform pour déployer une VM Linux sur Azure avec Apache installé automatiquement.

## Prérequis
- Terraform installé
- Azure CLI installé et connecté à votre compte Azure Student
- Compte Azure Student actif

## Connexion à Azure
```bash
az login
az account show
```

## Déploiement de l'infrastructure

### 1. Initialiser Terraform
```bash
terraform init
```

### 2. Vérifier le plan d'exécution
```bash
terraform plan
```

### 3. Déployer l'infrastructure
```bash
terraform apply
```

### 4. Accéder au serveur Apache
Après le déploiement, utilisez l'URL affichée dans les outputs :
```bash
# L'URL sera affichée automatiquement
# Ex: http://<IP_PUBLIQUE>
```

## Test de l'infrastructure
```bash
# Récupérer l'IP publique
terraform output public_ip_address

# Tester le serveur Apache
curl http://$(terraform output -raw public_ip_address)

# Se connecter en SSH
ssh azureuser@$(terraform output -raw public_ip_address)
```

## Destruction de l'infrastructure
```bash
terraform destroy
```

## Ressources créées (déclaratives)
- ✅ Groupe de ressources Azure
- ✅ Réseau virtuel (VNet)
- ✅ Sous-réseau
- ✅ IP publique statique
- ✅ Groupe de sécurité réseau (NSG)
  - Règle SSH (port 22)
  - Règle HTTP (port 80)
- ✅ Interface réseau
- ✅ Machine virtuelle Linux (Ubuntu 22.04 LTS)
- ✅ Installation automatique d'Apache via cloud-init

## Notes pour Azure Student
- La taille de VM `Standard_B1s` est adaptée aux limitations du compte Student
- Région `francecentral` pour une latence optimale
- Toutes les ressources sont dans le même groupe pour faciliter la gestion

## Architecture
L'infrastructure est entièrement déclarative :
- Pas de scripts impératifs
- Configuration cloud-init intégrée dans la ressource VM
- Dépendances gérées automatiquement par Terraform
