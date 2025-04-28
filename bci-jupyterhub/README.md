# SLE BCI container with JupyterLab

- https://registry.suse.com/
- https://jupyter.org/

# Requirements

- Storage: Resulting image is ~410 MB

# Build

```
docker buildx build -t bci-jupyterhub -f Dockerfile .
```

# Run

```
# APP_UID sets the uid the jupyter instance inside the container; defaults to 1000 if not set

APP_UNAME=$USER APP_UID=$(id -u) APP_PASS=<SET PASSWORD> docker compose up -d
```

# Notes

- https://denibertovic.com/posts/handling-permissions-with-docker-volumes/
