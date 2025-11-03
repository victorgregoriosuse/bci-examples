# MLflow with Local Filesystem Backend

## Overview

This directory contains an example `docker-compose.yml` file for deploying an MLflow tracking server that uses the local filesystem for backend storage and artifact rooting.

The container used in this example is from the SUSE Application Collection:
- `dp.apps.rancher.io/containers/mlflow:3.5.0`

## Container Details

This setup launches a single service:

*   **`mlflow_server`**: The MLflow tracking server.

The server is configured to use a directory inside the container (`/mlflow/data`) for both the backend store and artifact storage. This data is persisted to a docker volume named `mlflow_data`.

## Usage

### Start the Service

To start the MLflow server, run the following command from this directory:

```bash
docker compose up -d
```

The MLflow server will be available at `http://localhost:5001`.

### Stop the Service

To stop the service and remove the container, run:

```bash
docker compose down
```

To also remove the data volume (MLflow data), use:

```bash
docker compose down --volumes
```

## Reference

- [MLflow Documentation](https://mlflow.org/docs/latest/index.html)