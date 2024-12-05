# creer un principal de service pour mon databrics + un role

# creation de mon app
az ad app create --display-name "myAzureDBApp"

#récupération de l'app id 
app_id=$(az ad app show --display-name "myAzureDBApp" --query appId -o tsv)

# export de mon app id dans mon .env
echo "APP_ID=$appId" >> .env

# creation de mon service principal pour permettre à l'app d'accéder au storage account
az ad sp create-for-rbac --name $SERVICE_PRINCIPAL --role $ROLE_NAME  --scopes $STORAGE_ACCOUNT_SCOPE

