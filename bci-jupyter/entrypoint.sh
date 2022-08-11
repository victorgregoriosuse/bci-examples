#!/bin/bash

# optional debug option
[[ $DEBUG -eq 1 ]] && set -x

# add container user, passed LOCAL_USERID required
CONT_UID=${LOCAL_USERID:?}
CONT_UNAME=jupyter
CONT_HOME=/home/${CONT_UNAME}

echo "Starting with UID : $CONT_UID"
groupadd mail
useradd -s /bin/bash -u $CONT_UID -d $CONT_HOME -m $CONT_UNAME

# useradd will not apply skel files if the container homedir is created
# via a container engine's --mount flag, so force the copy of these files.
cp -ar /etc/skel/. ${CONT_HOME}/
chown -R $CONT_UID $CONT_HOME

# place container engine CMD into a script to facilitate an exec
echo "$@" >> /usr/local/bin/cmd.sh
chmod +x /usr/local/bin/cmd.sh

# exec CMD as the local user 
exec su - $CONT_UNAME -c /usr/local/bin/cmd.sh

