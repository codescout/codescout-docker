FROM ubuntu:14.04
MAINTAINER Dan Sosedoff "dan@doejo.com"

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN echo "LC_ALL=\"en_US.UTF-8\"" >> /etc/default/locale

RUN apt-get update
RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8
RUN apt-get install -y wget curl git-core software-properties-common

# Install Ruby 2.1 from Brightbox repository
RUN apt-add-repository ppa:brightbox/ruby-ng && \
    apt-get update && \
    apt-get install -y ruby2.1 ruby2.1-dev

RUN echo "gem: --no-rdoc --no-ri" > /etc/gemrc
RUN gem update --system

# Install code scout runner library
RUN gem install codescout-runner

# Needed to install identity keys for private projects
RUN mkdir -p /root/.ssh && \
    touch /root/.ssh/authorized_keys && \
    touch /root/.ssh/id_rsa && \
    touch /root/.ssh/id_rsa.pub && \
    chmod 700 /root/.ssh && \
    chmod 600 /root/.ssh/*

# SSH config is needed to skip console prompt when cloning repository for the
# first time. Not the best way of doing it, but its ok for now.
ADD config/ssh_config /root/.ssh/config

# HOME env variable is not set by default
ENV HOME /root

# Default working directory is "/" by default
WORKDIR /root

# Set default command
CMD ["codescout-runner"]