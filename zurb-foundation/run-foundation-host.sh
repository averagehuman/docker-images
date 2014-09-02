#!/bin/bash

caller=$(cat /etc/passwd | grep $USER)
caller_uid=$(echo $caller | cut -f3 -d:)
caller_gid=$(echo $caller | cut -f4 -d:)

mkdir -p /opt/zurb

exec docker run -e RUN_AS_UID=$caller_uid -e RUN_AS_GID=$caller_gid -v /opt/zurb:/home/bob hamcat/zurb-foundation $@

