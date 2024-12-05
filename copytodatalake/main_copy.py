from script_copy import get_response_url, upload_file_to_datalake, get_datalake_client, file_system_name, file_name 
from script_copy import get_urls_list_from_page, upload_multiple_files

datalake_client = get_datalake_client() 

def copy_one_file():
# appeler mes fonctions pour rendre le fonctionnement plus digeste
    file_content = get_response_url()
    upload_file_to_datalake(datalake_client, file_content, file_system_name, file_name)

def copy_several_files():
    file_urls = get_urls_list_from_page()
    upload_multiple_files(datalake_client, file_urls, file_system_name)


# l'utilisateur choisit de copier un ou plusieurs fichiers (et renseigne leur url dans le .env) en appelant sa fonction
#copy_one_file()
copy_several_files()