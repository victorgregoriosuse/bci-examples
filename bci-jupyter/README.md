# SLE BCI container with Jupyter Notebook

- https://registry.suse.com/
- https://jupyter.org/

# Requirements

- Storage: Resulting image is ~390 MB

# Podman Example

## Build

```
sudo podman build -t jupyter --progress=plain .
```

## Run

The entrypoint script will create /home/localuser inside the 
container, and align its UID with the UID of the user executing 
the podman run command.

```
mkdir -p workdir
```

```
sudo podman run \
 --mount type=bind,source="$(pwd)/workdir",target=/home/localuser \
 --network host \
 --env LOCAL_USERID=$UID \
 localhost/jupyter
```
