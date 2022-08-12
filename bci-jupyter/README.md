# SLE BCI container with JupyterLab

- https://registry.suse.com/
- https://jupyter.org/

# Requirements

- Storage: Resulting image is ~410 MB

# Podman Example

## Build

JupyterLab is installed into the /home/virtenv virtual environment.

```
sudo podman build -t jupyterlab --progress=plain .
```

## Run

The entrypoint script will create the username jupyter inside the container
and use $LOCAL_USERID to align the container's jupyter UID with the UID of 
the user executing the podman run command.  

JupyterLab is then launched from the virtual environment in 
/home/virtenv with the start directory of /home/jupyter. 

Environment Variables

- LOCAL_USERID is required and should match the local UID
- DEBUG=1 is optional, enables verbosity and editing of virtenv

```
mkdir -p jupyterlab
sudo podman run \
 --mount type=bind,source="$(pwd)/jupyterlab",target=/home/jupyterlab \
 --network host \
 --env LOCAL_USERID=$UID \
 --env DEBUG=0 \
 localhost/jupyterlab
```
