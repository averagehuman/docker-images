

# hamcat/zurb-foundation

FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update
RUN apt-get -y install git mercurial subversion
RUN apt-get -y install ruby ruby-dev rubygems-integration
RUN apt-get -y install npm nodejs

RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN npm install -g bower grunt-cli
RUN gem install compass
RUN gem install foundation

COPY run-foundation-container.sh /usr/bin/run-foundation
RUN chmod +x /usr/bin/run-foundation

RUN adduser --disabled-password --home=/home/bob --gecos "" bob

ENV HOME /home/bob
WORKDIR /home/bob

ENTRYPOINT ["run-foundation"]

