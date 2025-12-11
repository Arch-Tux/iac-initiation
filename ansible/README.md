# Ansible - Configuration Apache

## 📋 Description
Playbook Ansible **idempotent** pour installer et configurer Apache sur la VM Azure créée par Terraform.

## 🎯 Objectifs
- ✅ Installer Apache sur la VM
- ✅ Déployer le fichier index.html personnalisé
- ✅ S'assurer qu'Apache soit démarré et activé au boot
- ✅ Garantir l'idempotence (rejouable sans effet de bord)

## 📁 Structure
```
ansible/
├── ansible.cfg       # Configuration Ansible
├── inventory.yml     # Inventaire dynamique (IP depuis Terraform)
├── playbook.yml      # Playbook principal (idempotent)
└── run.sh           # Script d'exécution
```

## 🚀 Utilisation

### Méthode 1 : Script automatique
```bash
cd ansible
./run.sh
```

### Méthode 2 : Commande directe
```bash
cd ansible
ansible-playbook playbook.yml
```

### Méthode 3 : Avec tags spécifiques
```bash
cd ansible
# Installation uniquement
ansible-playbook playbook.yml --tags setup

# Déploiement du contenu uniquement
ansible-playbook playbook.yml --tags content

# Validation uniquement
ansible-playbook playbook.yml --tags validation
```

## 🔄 Idempotence
Le playbook peut être exécuté plusieurs fois sans problème :
- Les modules `apt` et `systemd` sont idempotents par nature
- Le module `copy` ne copie que si le fichier a changé
- Les handlers ne sont déclenchés que si nécessaire

**Test d'idempotence :**
```bash
# Première exécution : changements appliqués
ansible-playbook playbook.yml

# Deuxième exécution : aucun changement (changed=0)
ansible-playbook playbook.yml
```

## 🧪 Vérification

### Vérifier la configuration
```bash
# Tester la connexion
ansible all -m ping

# Vérifier qu'Apache tourne
ansible all -m shell -a "systemctl status apache2"

# Tester l'accès HTTP
curl http://$(cd .. && terraform output -raw public_ip_address)
```

### Mode dry-run (check mode)
```bash
# Voir ce qui serait fait sans l'exécuter
ansible-playbook playbook.yml --check
```

## 📝 Variables d'inventaire
L'inventaire récupère automatiquement l'IP publique depuis Terraform :
- `ansible_host` : IP publique (depuis `terraform output`)
- `ansible_user` : azureuser
- `ansible_become` : sudo activé

## 🔧 Personnalisation

### Modifier le fichier déployé
Éditez [../index.html](../index.html) puis rejouez le playbook.

### Ajouter des tâches
Les tâches Ansible utilisent des modules déclaratifs garantissant l'idempotence.
