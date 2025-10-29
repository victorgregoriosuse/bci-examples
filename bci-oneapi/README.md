# Intel oneAPI on SUSE SLE BCI

- https://registry.suse.com/
- https://www.intel.com/content/www/us/en/docs/oneapi/installation-guide-linux/2025-2/base-zypper.html#BASE-ZYPPER

# Requirements

- Storage: Resulting image is ~12.5GB

# Build
```bash
docker buildx build -t bci-oneapi -f Containerfile .
```

# Run
```
docker run -it bci-oneapi
```
