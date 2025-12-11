#!/bin/bash
set -e

echo "🚀 Exécution du playbook Ansible..."
echo ""

# Vérifier que Terraform a bien créé l'infrastructure
if ! cd .. && terraform output public_ip_address > /dev/null 2>&1; then
    echo "❌ Erreur: L'infrastructure Terraform n'est pas déployée"
    echo "   Exécutez d'abord: terraform apply"
    exit 1
fi

cd ansible

# Attendre que la VM soit prête
echo "⏳ Attente que la VM soit accessible (SSH)..."
IP=$(cd .. && terraform output -raw public_ip_address)

# Attendre max 120 secondes
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

# Exécuter le playbook
ansible-playbook playbook.yml -v

echo ""
echo "✅ Playbook exécuté avec succès!"
echo "🌐 Apache accessible sur: http://$IP"
