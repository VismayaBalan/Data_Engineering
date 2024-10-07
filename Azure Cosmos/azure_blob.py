from azure.storage.blob import ContainerClient, BlobClient, BlobServiceClient

connection_string = <connection-string>
account_key = <account-key>
account_name = "azurestoragedemo2239"

blob_storage_client = BlobServiceClient.from_connection_string(connection_string)

blobclient = BlobServiceClient(account_url= f"https://{account_name}.blob.core.windows.net/",   credential = account_key)

# Access container and list blobs
container_name = "azblobcontainer2239"
container_client = blob_storage_client.get_container_client(container_name)

# List all blobs in the container
blob_list = container_client.list_blob_names()

for blobs in blob_list:
    print(blobs)

# Create a container if it doesn't exists
def create_container(container_name):
    container_client = blob_storage_client.get_container_client(container_name) 
    try:
        container_client.create_container()
        print(f"Container {container_name} created.")
    except Exception as e:
        print(f"Container creation failed {e}")

def upload_blob(container_name, blob_name, data):
    blob_client = blobclient.get_blob_client(container = container_name, blob= blob_name)
    try:
        blob_client.upload_blob(data=data, overwrite=True)
        print("Blob created and data uploaded to the blob")
    except Exception as e:
        print(f"Blob Upload Failed!! {e}")

def delete_blob(container_name, blob_name):
    blob_client = blobclient.get_blob_client(container=container_name, blob = blob_name)
    print(f"Blob {blob_name} Deleted!")
    try:
        blob_client.delete_blob()
    except Exception as e:
        print(f"Blob deletion failed {e}")

def download_blob(container_name, blob_name, download_file_path):
    blob_client = blobclient.get_blob_client(container=container_name, blob = blob_name)
    try:
        with open(download_file_path,"wb") as fileobj:
            fileobj.write(blob_client.download_blob().readall())
    except Exception as e:
        print("Blob download failed")

if __name__ == "__main__":
    create_container("azurecontainer")
    upload_blob("azurecontainer", "blobfile.txt", "This is an example of blob upload.")
    download_blob("azurecontainer","blobfile.txt","C:/Users/Administrator/Downloads/Downloadblob.txt")
    delete_blob("azurecontainer","blobfile.txt")
    