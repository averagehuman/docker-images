

# hamcat/devpi-server:latest

FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update
RUN apt-get -y install python

# install setuptools from system packages
RUN apt-get -y install python-setuptools
RUN easy_install pip
# remove just-installed setuptools
RUN apt-get -y remove python-setuptools
# get latest setuptools
RUN pip install -U setuptools
# get latest virtualenv
RUN pip install -U virtualenv
# install orb
RUN pip install -U orb

RUN orb init /opt/devpi-server
RUN cd /opt/devpi-server && orb install -U devpi-server

COPY run.sh /usr/bin/devpi-server

VOLUME /srv/pypi
EXPOSE 3141

CMD ["/usr/bin/devpi-server"]


