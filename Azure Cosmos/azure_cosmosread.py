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

query = "SELECT * FROM c"

try:
    items = container.query_items(
        query = query,
        enable_cross_partition_query = True
    )

    count = 1
    for item in items:
        print(item)
        count += 1

    print(count)
except exceptions.CosmosHttpResponseError as e:
    print(f"An error occured {e.message}")