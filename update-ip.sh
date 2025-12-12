#!/bin/bash
set -e

echo "🔍 Récupération de l'IP publique actuelle..."

# Récupère l'IP IPv4 actuelle
CURRENT_IP=$(curl -4 -s ifconfig.me)

if [ -z "$CURRENT_IP" ]; then
    echo "❌ Impossible de récupérer l'IP publique"
    exit 1
fi

echo "📍 IP actuelle: $CURRENT_IP"

# Met à jour terraform.tfvars
if [ -f "terraform.tfvars" ]; then
    # Écrit le nouveau fichier
    cat > terraform.tfvars << EOF
allowed_ssh_ip = "$CURRENT_IP/32"
EOF

    echo "✅ terraform.tfvars mis à jour avec l'IP: $CURRENT_IP/32"
else
    echo "❌ Fichier terraform.tfvars non trouvé"
    exit 1
fi
