# SLE BCI container with Openfilter

## Container Details

* This container provides an environment with the `openfilter` utility pre-installed.
* The `openfilter` package and its dependencies are installed in a Python virtual environment located at `/opt/venv`.
* The virtual environment is automatically active in the default `bash` shell.

## Docker Deployment

### 1. Build Image
```bash
docker buildx build -t bci-openfilter -f Containerfile .
```

### 2. Run Container

To start an interactive shell in the container, run the following command:

```bash
docker run -it --rm bci-openfilter
```

This will drop you into a `bash` shell where you can use the `openfilter` command-line tool.

# Reference

- [Openfilter GitHub Repository](https://github.com/PlainsightAI/openfilter)
