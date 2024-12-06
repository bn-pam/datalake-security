## assignation de rôle via script
# rendre ce script executable : chmod +x datalake_assign_role_to_db.sh

#!/bin/bash

# Importer les variables depuis le fichier .env
if [ -f .env ]; then
  source .env
else
  echo "Erreur : Fichier .env introuvable dans le répertoire actuel."
  exit 1
fi

# # Créer un principal de service pour mon databrics + un role

# Création de l'application Azure
echo "Création de l'application Azure..."
app_create_output=$(az ad app create --display-name $APP_NAME --query appId -o tsv 2>&1)
if [ $? -ne 0 ]; then
  echo "Erreur lors de la création de l'application Azure : $app_create_output"
  exit 1
fi

# Récupération de l'ID de l'application
echo "Récupération de l'app ID..."
app_id=$(az ad app list --display-name "myAzureDBApp" --query "[0].appId" -o tsv)
if [ -z "$app_id" ]; then
  echo "Erreur : Impossible de récupérer l'app ID. Vérifie le nom de l'application."
  exit 1
fi
echo "APP_ID récupéré : $app_id"

# Export de l'app ID dans le fichier .env
echo "Export de l'APP_ID dans .env..."
echo "\nAPP_ID=\"$app_id\"" >> .env

# Création du principal de service
echo "Création du principal de service..."
sp_create_output=$(az ad sp create-for-rbac --name "$SERVICE_PRINCIPAL" --role "$ROLE_NAME" --scopes "$STORAGE_ACCOUNT_SCOPE" 2>&1)
if [ $? -ne 0 ]; then
  echo "Erreur lors de la création du principal de service : $sp_create_output"
  exit 1
fi

echo "Script exécuté avec succès."