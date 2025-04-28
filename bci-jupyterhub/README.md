# SLE BCI container with JupyterLab

- https://registry.suse.com/
- https://jupyter.org/

# Requirements

- Storage: Resulting image is ~787 MB

# Build

```
docker buildx build -t bci-jupyterhub -f Dockerfile .
```

# Run

```
# APP_UNAME  the username inside the container (default = jupyter)
# APP_UID    the uid for the username (default = 1000)
# APP_PASS   the username password for jupyterhub auth (default = CHANGEME)

APP_UNAME=$USER APP_UID=$(id -u) APP_PASS=<SET PASSWORD> docker compose up -d
```

# Notes

- https://denibertovic.com/posts/handling-permissions-with-docker-volumes/
