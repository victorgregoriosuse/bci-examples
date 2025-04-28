# SLE BCI container with JupyterLab

- https://registry.suse.com/
- https://jupyter.org/

# Requirements

- Storage: Resulting image is ~549 MB

# Build

```
docker buildx build -t bci-jupyterlab -f Dockerfile .
```

# Run

```
# APP_UNAMAE the username inside the container (default = jupyter)
# APP_UID    the uid for the username (default = 1000)

APP_UNAME=$USER APP_UID=$(id -u) docker compose up -d
```

# Notes

- https://denibertovic.com/posts/handling-permissions-with-docker-volumes/
