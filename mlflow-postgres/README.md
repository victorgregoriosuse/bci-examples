# MLflow with PostgreSQL Backend

## Overview

This directory contains an example `docker-compose.yml` file for deploying an MLflow tracking server with a PostgreSQL backend.

The containers used in this example are from the SUSE Application Collection:
- `dp.apps.rancher.io/containers/mlflow:3.5.0`
- `dp.apps.rancher.io/containers/postgresql:18.0`

## Container Details

This setup launches two services:

*   **`mlflow_server`**: The MLflow tracking server.
*   **`mlflow_db`**: The PostgreSQL database backend.

### `psycopg2` Installation

To enable communication between the MLflow server and the PostgreSQL database, the `psycopg2` package, a PostgreSQL adapater for Python, is installed within the `mlflow_server` container upon startup. 

## Security

The `docker-compose.yml` file uses default credentials for the PostgreSQL database. It is highly recommended to change the `POSTGRES_USER` and `POSTGRES_PASSWORD` environment variables in the `compose.yml` file for any production or sensitive environment.

## Usage

### Start the Services

To start the MLflow server and the PostgreSQL database, run the following command from this directory:

```bash
docker compose up -d
```

The MLflow server will be available at `http://localhost:5001`.

### Stop the Services

To stop the services and remove the containers, run:

```bash
docker compose down
```

To also remove the data volumes (database data and MLflow artifacts), use:

```bash
docker compose down --volumes
```

## Reference

- [MLflow Documentation](https://mlflow.org/docs/latest/index.html)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [psycopg2 Documentation](https://www.psycopg.org/docs/)
