# SLE BCI container with Jupyter Notebook

- https://registry.suse.com/
- https://jupyter.org/
- https://www.tensorflow.org/

# Requirements

- Storage: Resulting image is ~2.2 GB

# Podman Example

## Build

Jupyter Notebook and TensorFlow is installed into the /home/virtenv
virtual environment.

```
sudo podman build -t jupyter --progress=plain .
```

## Run

The entrypoint script will create the username jupyter inside the container
and use $LOCAL_USERID to align the container's jupyter UID with the UID of 
the user executing the podman run command.  Jupyter Notebook is then 
launched from /home/virtenv. 

Passing $LOCAL_USERID is required.

```
mkdir -p workdir
sudo podman run \
 --mount type=bind,source="$(pwd)/workdir",target=/home/jupyter \
 --network host \
 --env LOCAL_USERID=$UID \
 localhost/jupyter
```
