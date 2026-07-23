#!/bin/bash

CONTAINER_NAME="jenkins"
KEY_PATH="/var/jenkins_home/.ssh/id_ed25519"
PUBLIC_KEY_PATH="${KEY_PATH}.pub"

# 1. Vérifier si la clé publique existe dans le conteneur
if docker exec "$CONTAINER_NAME" test -f "$PUBLIC_KEY_PATH"; then
    echo "La clé existe déjà dans le conteneur."
    
    # Copier la clé publique du conteneur vers l'hôte (contexte de build)
    docker cp "$CONTAINER_NAME:$PUBLIC_KEY_PATH" ./id_ed25519.pub
    
else
    echo "Clé absente. Génération dans le conteneur..."
    
    # 2. S'assurer que le dossier .ssh existe et a les bons droits
    docker exec "$CONTAINER_NAME" mkdir -p /var/jenkins_home/.ssh
    docker exec "$CONTAINER_NAME" chmod 700 /var/jenkins_home/.ssh

    # 3. Générer la clé DIRECTEMENT dans le conteneur
    docker exec "$CONTAINER_NAME" ssh-keygen -t ed25519 -f "$KEY_PATH" -N "" -C "jenkins@docker"

    # 4. Copier la clé publique nouvellement créée vers l'hôte
    docker cp "$CONTAINER_NAME:$PUBLIC_KEY_PATH" ./id_ed25519.pub
    
    echo "Clé générée et récupérée avec succès."
fi   
