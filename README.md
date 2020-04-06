# mlflow-docker-compose
Deploy mlflow with docker-compose

# Deploy
## mlflow stores artifacts as per cloud choice get creditionals from clouds
## e.g
## 1. Login Google Cloud Platform
In this script, mlflow stores artifacts on Google Cloud Storage.
It means you must set up GCP Credentials.
If you already have `application_default_credentials.json`, go next chapter.

```sh
$ gcloud auth application-default login
```
`application_default_credentials.json` will be saved `${HOME}/.config/gcloud/`

Similarly
get AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY for aws

get AZURE_STORAGE_CONNECTION_STRING for azure.

## 2. Create .env file
In `docker-compose.yaml`, some parameters is loaded from `.env` file.
Set following parameters in `.env`.

- GCP_STORAGE_BUCKET: Google Cloud Storage bucket name mlflow will store artifact
- CREDENTIALS_PATH: Path to `application_default_credentials.json`
- GCLOUD_PROJECT: GCP Project name you use

```
GCP_STORAGE_BUCKET=demo-bucket
CREDENTIALS_PATH=~/.config/gcloud/application_default_credentials.json
GCLOUD_PROJECT=demo-project
MYSQL_PASSWORD=password
MYSQL_USER=user_name
MYSQL_DATABASE=db_name
AZURE_STROAGE_BUCKET=YOURCNTAINERNAME@YOURACCOUNTNAME.blob.core.windows.net/PATHOFFOLDER
AZURE_STORAGE_CONNECTION_STRING=azure_storage_account_connection_string
AWS_STORAGE_BUCKET=aws_s3_bucket_name/path/
AWS_ACCESS_KEY_ID=aws_access_key
AWS_SECRET_ACCESS_KEY=aws_access_password
```
## 2.1 Update start.sh file
Added the configuration for GCP, azure and AWS to store the artifacts in respective cloud
bucket locations, uncomment/comment the last line code as per cloud choice default is GCP.

## 3. Build and deploy
Build mlflow Dockerfile, and then deploy applications.

```sh
$ sudo docker-compose build
$ sudo docker-compose up -d
```

# Update MLflow version
If you want update MLflow, stop container and remove images, and then rebuild MLflow container.

```sh
$ sudo docker-compose stop mlflow && \
  sudo docker-compose rm mlflow && \
  docker images mlflow-docker-compose_mlflow --format '{{.ID}}'|xargs docker rmi && \
  sudo docker-compose build && \
  sudo docker-compose up -d
```

# This will deploy the mlflow tracking server on machine with all runs will be stored on mysql database and artifacts will be stored on cloud bucket.
```sh
$ http://machine-ip:5000/
```