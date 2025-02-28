import pandas as pd
from google.cloud import bigquery
import google.auth
import warnings

# Use default Google Cloud authentication
credentials, project = google.auth.default()
client = bigquery.Client(credentials=credentials, project=project)

# Define datasets
datasets = {

}

# Define queries
queries = {

}

# Execute and display each dataset followed by its related queries
for dataset_name, dataset in datasets.items():
    print(f"\nOriginal Dataset: {dataset_name}\n")
    query_job = client.query(f"SELECT * FROM `{dataset}` LIMIT 5")
    dataset_preview = query_job.to_dataframe()
    display(dataset_preview)
    
    # Execute related queries
    for title, query in queries.items():
        if dataset.split(".")[-1] in query:
            print(f"\nRunning query: {title}\n")
            query_job = client.query(query)
            results = query_job.to_dataframe()
            display(results)