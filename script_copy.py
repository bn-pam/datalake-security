import os
from azure.storage.filedatalake import DataLakeServiceClient
from azure.identity import ClientSecretCredential
from azure.keyvault.secrets import SecretClient
from dotenv import load_dotenv
import uuid

# Charger les variables d'environnement depuis le fichier .env
load_dotenv()

# Récupérer les informations du Service Principal 2 depuis .env
sp2_id = os.getenv('SP_ID_SECONDARY')
sp2_secret = os.getenv('SP_SECONDARY_PASSWORD')
tenant_id = os.getenv('TENANT_ID')
vault_url = os.getenv('KEYVAULT_URL')
storage_account_name = os.getenv('STORAGE_ACCOUNT_NAME')

# Récupérer les secrets stockés dans Azure Key Vault pour le Service Principal 1
# Je donne mes infos sur le secondary 
credential2 = ClientSecretCredential(tenant_id, sp2_id, sp2_secret)

# Aller sur le keyvault récupérer le sp1 grâce à l'url du keyvault qu'on a créé précedemment, et fourni dans le .env et aux credentials donnés ci-dessus. 
secret_client = SecretClient(vault_url=vault_url, credential=credential2)

# Supposons que vous avez un secret pour le Service Principal 1 dans le Key Vault
sp1_secret = secret_client.get_secret("ServicePrincipal1Secret")
sp1_client_id = sp1_secret.value

# Créer un client pour le Service Principal 1
sp1_credential = ClientSecretCredential(tenant_id, sp1_client_id, client_secret)

# Créer un client DataLake pour interagir avec Azure Data Lake Gen2
def get_datalake_client():
    service_client = DataLakeServiceClient(
        account_url=f"https://{storage_account_name}.dfs.core.windows.net",
        credential=sp1_credential
    )
    return service_client

def upload_file_to_datalake(local_file_path, file_system_name, file_name):
    datalake_client = get_datalake_client()
    file_system_client = datalake_client.get_file_system_client(file_system_name)
    
    # Créer ou obtenir un fichier dans le DataLake
    file_client = file_system_client.create_file(file_name)
    
    with open(local_file_path, "rb") as local_file:
        file_client.append_data(local_file.read(), 0)
        file_client.flush_data(local_file.tell())
    print(f"File '{file_name}' uploaded successfully to Data Lake.")

# Exemple d'utilisation
local_file_path = "path/to/your/file.csv"
file_system_name = "your-file-system-name"
file_name = f"uploaded_file_{uuid.uuid4().hex}.csv"  # Nom dynamique pour éviter les collisions

upload_file_to_datalake(local_file_path, file_system_name, file_name)
