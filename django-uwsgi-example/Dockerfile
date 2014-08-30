

# hamcat/django-uwsgi-example:latest

FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

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

# django app
RUN orb init /opt/django
COPY bootstrap.py /opt/django/bootstrap.py
COPY buildout.cfg /opt/django/buildout.cfg
COPY requirements.txt /opt/django/requirements.txt
COPY setup.py /opt/django/setup.py
COPY instance /opt/django/instance
COPY vendor /opt/django/vendor

RUN cd /opt/django && orb install --no-index --find-links vendor -r requirements.txt

COPY run-django.sh /usr/bin/django
COPY run-uwsgi.sh /usr/bin/uwsgi

RUN apt-get -y remove build-essential
RUN rm -rf /opt/django/vendor

