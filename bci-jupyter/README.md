# SLE BCI container with JupyterLab

- https://registry.suse.com/
- https://jupyter.org/

# Requirements

- Storage: Resulting image is ~410 MB

# Build

```
docker buildx build -t bci-jupyter -f Containerfile .
```

# Run

```
# APP_UID sets the uid the jupyter instance inside the container; defaults to 1000 if not set
# This will also mount ./notebooks as the $HOME of the jupyter lab user

APP_UID=$(id -u) docker compose up -d
```

# Notes

- https://denibertovic.com/posts/handling-permissions-with-docker-volumes/
