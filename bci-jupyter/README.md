# SLE BCI container with JupyterLab

- https://registry.suse.com/
- https://jupyter.org/

# Requirements

- Storage: Resulting image is ~410 MB


# Build

JupyterLab is installed into the /home/virtenv virtual environment.

```
docker buildx build -t sle-jupyter -f Containerfile .
```

# Run

```
docker compose up -d
```

# Notes

- https://denibertovic.com/posts/handling-permissions-with-docker-volumes/
