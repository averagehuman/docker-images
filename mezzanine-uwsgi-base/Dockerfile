

# hamcat/mezzanine-uwsgi

FROM hamcat/python-base:en_GB

# django app
RUN orb init /opt/django
COPY bootstrap.py /opt/django/bootstrap.py
COPY base.cfg /opt/django/base.cfg
COPY buildout.cfg /opt/django/buildout.cfg
COPY requirements.txt /opt/django/core-requirements.txt
COPY setup.py /opt/django/setup.py
COPY instance /opt/django/instance
COPY vendor /opt/django/vendor

WORKDIR /opt/django
RUN orb install --no-index --find-links vendor -r core-requirements.txt
RUN rm core-requirements.txt
RUN orb buildout

COPY run-django.sh /usr/bin/django
COPY run-uwsgi.sh /usr/bin/uwsgi

RUN apt-get -y remove build-essential
RUN apt-get -y clean
RUN apt-get -y autoremove

