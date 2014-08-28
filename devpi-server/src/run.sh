#!/bin/bash

exec /opt/devpi-server/bin/devpi-server --port=3141 --serverdir=/srv/pypi --refresh=600
