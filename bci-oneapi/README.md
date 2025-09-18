# Intel oneAPI on SUSE SLE BCI

- https://registry.suse.com/
- https://www.intel.com/content/www/us/en/developer/tools/oneapi/toolkits.html

# Requirements

- Storage: Resulting image is ~15GB

# Podman
Build
```
podman build -t bci-oneapi -f Containerfile .
```
Run
```
podman run -it bci-oneapi
```

# Docker
Build
```
docker buildx build -t bci-oneapi -f Containerfile .
```
Run
```
docker run -it bci-oneapi
```
