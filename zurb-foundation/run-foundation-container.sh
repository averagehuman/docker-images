#!/bin/bash

# based on code from - http://chapeau.freevariable.com/2014/08/docker-uid.html
env
# determine container user "bob's" info
ORIGPASSWD=$(cat /etc/passwd | grep bob)
ORIG_UID=$(echo $ORIGPASSWD | cut -f3 -d:)
ORIG_GID=$(echo $ORIGPASSWD | cut -f4 -d:)
ORIG_HOME=$(echo $ORIGPASSWD | cut -f6 -d:)

# expect environment variables RUN_AS_UID and RUN_AS_GID, fallback to originals
RUN_AS_UID=${RUN_AS_UID:=$ORIG_UID}
RUN_AS_GID=${RUN_AS_GID:=$ORIG_GID}

# update bob's info
sed -i -e "s/:$ORIG_UID:$ORIG_GID:/:$RUN_AS_UID:$RUN_AS_GID:/" /etc/passwd
sed -i -e "s/bob:x:$ORIG_GID:/bob:x:$RUN_AS_GID:/" /etc/group

chown -R ${RUN_AS_UID}:${RUN_AS_GID} ${ORIG_HOME}

exec su - bob -c "foundation $@"
