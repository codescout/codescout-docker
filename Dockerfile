FROM ubuntu:14.04
MAINTAINER Dan Sosedoff "dan@doejo.com"

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN echo "LC_ALL=\"en_US.UTF-8\"" >> /etc/default/locale

RUN apt-get update
RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8
RUN apt-get install -y wget curl git-core software-properties-common

RUN apt-add-repository ppa:brightbox/ruby-ng && \
    apt-get update && \
    apt-get install -y ruby2.1 ruby2.1-dev

RUN echo "gem: --no-rdoc --no-ri" > /etc/gemrc

RUN gem update --system
RUN gem install bundler

# Install codescout gems
RUN git clone https://github.com/codescout/codescout-analyzer.git && \
    cd codescout-analyzer && \
    rake build && \
    gem install pkg/codescout-analyzer-0.0.1.gem && \
    cd .. && \
    rm -rf codescout-analyzer

RUN git clone https://github.com/codescout/codescout-runner.git && \
    cd codescout-runner && \
    rake build && \
    gem install pkg/codescout-runner-0.0.1.gem && \
    cd .. && \
    rm -rf codescout-runner

# Needed to install identity keys for private projects
RUN mkdir -p /root/.ssh && \
    touch /root/.ssh/authorized_keys && \
    touch /root/.ssh/id_rsa && \
    touch /root/.ssh/id_rsa.pub && \
    chmod 700 /root/.ssh && \
    chmod 600 /root/.ssh/*

# SSH config is needed to skip console prompt when cloning repository for the
# first time. Not the best way of doing it, but its ok for now.
ADD data/ssh_config /root/.ssh/config