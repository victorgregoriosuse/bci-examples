# MLflow with MariaDB Backend

## Overview

This directory contains an example `docker-compose.yml` file for deploying an MLflow tracking server with a MariaDB backend.

The containers used in this example are:
- `dp.apps.rancher.io/containers/mlflow:3.5.0`
- `dp.apps.rancher.io/containers/mariadb:11.8.3`

## Container Details

This setup launches two services:

*   **`mlflow_server`**: The MLflow tracking server.
*   **`mlflow_db`**: The MariaDB database backend.

### `pymysql` Installation

To enable communication between the MLflow server and the MariaDB database, the `pymysql` package, a pure-Python MySQL client library, is installed within the `mlflow_server` container upon startup.

## Security

The `docker-compose.yml` file uses default credentials for the MariaDB database. It is highly recommended to change the `MARIADB_ROOT_PASSWORD`, `MARIADB_DATABASE`, `MARIADB_USER` and `MARIADB_PASSWORD` environment variables in the `compose.yml` file for any production or sensitive environment.

## Usage

### Start the Services

To start the MLflow server and the MariaDB database, run the following command from this directory:

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
- [MariaDB Documentation](https://mariadb.com/kb/en/documentation/)
- [PyMySQL Documentation](https://pymysql.readthedocs.io/)
