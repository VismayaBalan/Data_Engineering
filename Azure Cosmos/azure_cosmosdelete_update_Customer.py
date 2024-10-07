from azure.cosmos import exceptions, CosmosClient, PartitionKey
import json

# Initialize the cosmos client
endpoint = <endpoint>
key = <account-key>
DATABASE_NAME = "bank-azuredb"
CONTAINER_NAME = "bankcontainer"

# Create a cosmos client
client = CosmosClient(endpoint,key)

# select the database
database = client.get_database_client(DATABASE_NAME)

# select container name
container = database.get_container_client(CONTAINER_NAME)

updated_data =    {
        "id": "ust10004",
        "name": "Vismaya",
        "product": "Laptop",
        "brand-name": "hp",
        "Country": "United States",
        "amount": 120000
    }

try:
    item_to_update = container.read_item(item="ust10004", partition_key="United States")
        
    # Update the item's data
    for key, value in updated_data.items():
        item_to_update[key] = value

    # Replace the item in the container
    container.replace_item(item="ust10004", body=item_to_update)
    print(f"Item has been updated successfully.")
except exceptions.CosmosHttpResponseError as e:
        print(f"An error occurred while updating item: {e.message}")


container.delete_item(item="ust10005", partition_key="Brazil")

query = "SELECT TOP 2 *  FROM c"

try:
    items = container.query_items(
        query = query,
        enable_cross_partition_query = True
    )

    
    for item in items:
        print(item)

except exceptions.CosmosHttpResponseError as e:
    print(f"An error occured {e.message}")


