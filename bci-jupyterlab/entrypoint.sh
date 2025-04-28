#!/bin/bash

JUPYTER_VENV=/app/jupyterlab

# default to uid 1000 inside the container
APP_UNAME=${APP_UNAME:-jupyter}
APP_UID=${APP_UID:-1000}
APP_HOME=/home/${APP_UNAME}

echo "Starting with $APP_UNAME($APP_UID)"
groupadd mail
useradd -s /bin/bash -u $APP_UID -d $APP_HOME -m $APP_UNAME

# useradd will not apply skel files if the container homedir is present, so we force it
cp -ar /etc/skel/. ${APP_HOME}/

# set ownership of homedir and venv to container user
chown -R $APP_UID $APP_HOME
chown -R $APP_UID $JUPYTER_VENV

# Containerfile CMD inside a script to facilitate an exec
echo "$@" > /app/cmd.sh
chmod +x /app/cmd.sh

# exec CMD as the local user 
exec su - $APP_UNAME -c /app/cmd.sh
