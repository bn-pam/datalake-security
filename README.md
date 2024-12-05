# datalake-security

## passwordgen 
consists in a password generator of 16 caracters including special caracters
it copies it in a variables.tfvars file in the same module

## copytodatalake
consists in a file-copier to a specific datalake
needs a .env file with following attributes : 
SP_ID_SECONDARY=""
SP_SECONDARY_PASSWORD=""
SP_ID_PRINCIPAL=""
TENANT_ID=""
KEYVAULT_URL=""
SECRET_NAME=""
STORAGE_ACCOUNT_NAME=""
CONTAINER_NAME=""
FILE_PATH=""

## keyvault (and keyvault_secret)
consists in a keyvault secret generator
creates a keyvault if it does not exist already
