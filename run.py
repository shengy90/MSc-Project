

if __name__ == "__main__":
    auth.authenticate_user()
    print('Authenticated')
    credentials, your_project_id = google.auth.default(scopes=["https://www.googleapis.com/auth/cloud-platform"])
    your_project_id = 'machine-learning-msc'
    # Make clients.
    bqclient = bigquery.Client(
        credentials=credentials,
        project=your_project_id
    )
    bqstorageclient = bigquery_storage_v1beta1.BigQueryStorageClient(
        credentials=credentials
    )
