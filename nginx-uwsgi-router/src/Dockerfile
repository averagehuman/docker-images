
# Generated Dockerfile - do not edit!

FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update
RUN apt-get -y install python python-dev
RUN apt-get -y install supervisor

COPY nginx /opt/nginx-1.6.1-demo
COPY uwsgi /usr/local/bin/uwsgi
COPY supervisor.conf /etc/supervisor/conf.d/frontend.conf
RUN ln -s /opt/nginx-1.6.1-demo/bin/nginx /usr/local/bin/nginx


EXPOSE 80 3030

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisor.conf"]

