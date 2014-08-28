
# Generated Dockerfile - do not edit!

FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update
RUN apt-get -y install python python-dev
RUN apt-get -y install supervisor

COPY nginx /opt/nginx-1.6.1-demo
COPY uwsgi /usr/local/bin/uwsgi
RUN ln -s /opt/nginx-1.6.1-demo/bin/nginx /usr/local/bin/nginx
RUN mkdir -p /var/www

COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY router.conf /etc/supervisor/conf.d/programs.conf

EXPOSE 80 3030

CMD ["/usr/bin/supervisord"]

