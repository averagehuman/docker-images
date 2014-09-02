

# hamcat/mezzanine-dev-example

FROM hamcat/mezzanine-uwsgi

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_GB.UTF-8
RUN dpkg-reconfigure locales
ENV LANG en_GB.UTF-8
ENV LC_ALL en_GB.UTF-8

# django app
COPY instance /opt/django/instance

EXPOSE 8080

