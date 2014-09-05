

# hamcat/mezzanine-uwsgi

FROM hamcat/python-base:en_GB

# django app
RUN orb init /opt/django
COPY bootstrap.py /opt/django/bootstrap.py
COPY base.cfg /opt/django/.base.cfg
COPY buildout.cfg /opt/django/buildout.cfg
COPY requirements.txt /opt/django/core-requirements.txt
COPY setup.py /opt/django/setup.py
COPY instance /opt/django/instance
COPY vendor /opt/django/vendor

WORKDIR /opt/django

# install core requirements to virtualenv site-packages
RUN orb install --no-index --find-links vendor -r core-requirements.txt

# but need a dummy requirements file to satisfy the gp.vcsdevelop buildout extension
RUN touch requirements.txt

# run buildout to create the ancillary directories and binaries
RUN orb buildout

# now clean up the build-time artefacts
RUN rm core-requirements.txt
RUN rm buildout.cfg
RUN rm .installed.cfg

COPY run-django.sh /usr/bin/django
COPY run-uwsgi.sh /usr/bin/uwsgi

RUN apt-get -y remove build-essential
RUN apt-get -y clean
RUN apt-get -y autoremove

ONBUILD WORKDIR /opt/django
ONBUILD COPY settings.py /opt/django/instance/
ONBUILD COPY urls.py /opt/django/instance/
ONBUILD COPY buildout.cfg /opt/django/
ONBUILD RUN orb buildout

