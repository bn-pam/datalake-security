import os
from azure.storage.filedatalake import DataLakeServiceClient
from azure.identity import ClientSecretCredential
from azure.keyvault.secrets import SecretClient
from dotenv import load_dotenv
import uuid, requests

# Charger les variables d'environnement depuis le fichier .env
load_dotenv()

# Récupérer les informations du Service Principal 2 depuis .env
sp2_id = os.getenv('SP_ID_SECONDARY')
sp2_secret = os.getenv('SP_SECONDARY_PASSWORD')
tenant_id = os.getenv('TENANT_ID')
vault_url = os.getenv('KEYVAULT_URL')
storage_account_name = os.getenv('STORAGE_ACCOUNT_NAME')
sp1_id = os.getenv('SP_ID_PRINCIPAL')
sp1_secret = os.getenv('SECRET_NAME')

# Récupérer les informations du fichier à uploader
upload_file_path = os.getenv('FILE_PATH')
file_system_name = os.getenv('CONTAINER_NAME')
file_name = f"{file_system_name}_{uuid.uuid4().hex}.csv"  # Nom dynamique pour éviter les collisions

# Récupérer les secrets stockés dans Azure Key Vault pour le Service Principal 1
# Je donne mes infos concernant le secondary pour m'authentifier (vérifier que c'est moi pour ouvrir le coffre)
sp2_credential = ClientSecretCredential(tenant_id, sp2_id, sp2_secret)

# Aller sur le keyvault récupérer le sp1 grâce à l'url du keyvault qu'on a créé précedemment, et fourni dans le .env et aux credentials du sp2 donnés ci-dessus. 
# secret_client est une variable qui permet d'interroger le key vault
# cela nous donne acces au coffre dans la limite des autorisations de la clé du sp2
secret_client = SecretClient(vault_url=vault_url, credential=sp2_credential)

# interroger le keyvault pour donner le secret du Service Principal 1 : get_secret obtient les infos (value, name, id et properties, et .value retourne juste la valeur du secret)
sp1_secret = secret_client.get_secret(sp1_secret).value

# Créer un client pour le Service Principal 1
sp1_credential = ClientSecretCredential(tenant_id, sp1_id, sp1_secret)

# Créer un client DataLake pour interagir avec Azure Data Lake Gen2 avec la clé du sp1 obtenue précedemment
def get_datalake_client():
    service_client_datalake = DataLakeServiceClient(
        account_url=f"https://{storage_account_name}.dfs.core.windows.net",
        credential=sp1_credential
    )
    return service_client_datalake


# fonction de récupération de fichier depuis request
def get_response_url() :
    url = upload_file_path
    # Télécharger le fichier depuis l'URL
    response = requests.get(url)
    if response.status_code == 200:
        return response.content
        print("Fichier téléchargé avec succès depuis l'URL.")
    else:
        print(f"Échec du téléchargement, code de statut: {response.status_code}")
        exit(1)

# fonction permettant d'uploader le fichier sur le datalake
def upload_file_to_datalake(file_content, file_system_name, file_name):

    file_system_client = datalake_client.get_file_system_client(file_system_name)
    
    # Copier un fichier dans le DataLake
    file_client = file_system_client.create_file(file_name)
    file_client.append_data(file_content, 0)
    file_client.flush_data(len(file_content)) #taille totale du contenu du fichier (en bytes). 
    #Cela est important car Azure Data Lake utilise cette information pour s'assurer que toutes les données ont bien été envoyées et que la session d'écriture est terminée.

    print(f"File '{file_name}' uploaded successfully to Data Lake.")

# appeler mes fonctions pour rendre le fonctionnement plus digeste
file_content = get_response_url()
datalake_client = get_datalake_client()
upload_file_to_datalake(file_content, file_system_name, file_name)
