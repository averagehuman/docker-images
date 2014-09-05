
# hamcat/python-base

FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_GB.UTF-8
RUN dpkg-reconfigure locales
ENV LANG en_GB.UTF-8
ENV LC_ALL en_GB.UTF-8


RUN apt-get -y update
RUN apt-get -y install build-essential
RUN apt-get -y install software-properties-common
RUN apt-get -y install python python-dev
RUN apt-get -y install postgresql-client libpq-dev
RUN apt-get -y install libtiff5-dev libjpeg8-dev zlib1g-dev
RUN apt-get -y install libfreetype6 libfreetype6-dev
RUN apt-get -y install liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk
RUN apt-get -y install git mercurial subversion

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

# java
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get -y update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java7-installer

RUN apt-get -y clean
RUN apt-get -y autoremove

