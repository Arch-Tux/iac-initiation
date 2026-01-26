#!/bin/bash
set -e

echo "🚀 Exécution du playbook Ansible..."
echo ""

# Vérifie que Terraform a bien créé l'infrastructure
if ! cd ../terraform && terraform output public_ip_address > /dev/null 2>&1; then
    echo "❌ Erreur: L'infrastructure Terraform n'est pas déployée"
    echo "   Exécutez d'abord: terraform apply"
    exit 1
fi

cd ../ansible

# Check VM soit prête
echo "⏳ Attente que la VM soit accessible (SSH)..."
IP=$(cd ../terraform && terraform output -raw public_ip_address)

# Timout 120 secondes
counter=0
max_attempts=60
while ! nc -z $IP 22 2>/dev/null; do
    sleep 2
    counter=$((counter + 1))
    if [ $counter -ge $max_attempts ]; then
        echo "❌ La VM n'est pas accessible sur le port SSH après 120 secondes"
        exit 1
    fi
done

echo "✅ VM accessible"
echo ""

# Run playbooks
ansible-playbook playbook.yml -v

echo ""
echo "✅ Playbook exécuté avec succès!"
echo "🌐 Apache accessible sur: http://$IP"

# Fermer automatiquement le port SSH pour la sécurité
echo ""
echo "🔒 Fermeture du port SSH pour sécuriser la VM..."

# Récupérer dynamiquement les valeurs depuis Terraform
RG=$(cd ../terraform && terraform output -raw resource_group_name 2>/dev/null)
VM_NAME=$(cd ../terraform && terraform output -raw vm_name 2>/dev/null)
NSG="nsg-$VM_NAME"

az network nsg rule delete \
  --resource-group "$RG" \
  --nsg-name "$NSG" \
  --name SSH \
  > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "✅ Port SSH fermé - VM sécurisée (plus d'accès SSH possible)"
else
    echo "⚠️ Impossible de fermer le port SSH automatiquement"
fi
