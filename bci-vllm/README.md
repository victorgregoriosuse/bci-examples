
## BUILD

```
podman build --build-arg MODEL=nvidia/nemotron-mini-4b-instruct --build-arg PORT=8000 -t sle-vllm -f Containerfile
```

## RUN

To use podman with `--device nvidia.com/gpu=all` without root, `--runtime=crun and --group-add keep-groups` is needed.

```
podman run -d --device nvidia.com/gpu=all --runtime=crun --group-add keep-groups -p 8000:8000 --name sle-vllm sle-vllm
```

