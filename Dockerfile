FROM ubuntu:12.04
MAINTAINER Dan Sosedoff "dan@doejo.com"

RUN echo "LC_ALL=\"en_US.UTF-8\"" >> /etc/default/locale

RUN apt-get update
RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8
RUN apt-get install -y wget curl git-core python-software-properties

RUN apt-add-repository ppa:brightbox/ruby-ng && \
    apt-get update && \
    apt-get install -y ruby2.1 ruby2.1-dev

RUN echo 'gem: --no-rdoc --no-ri' > /etc/gemrc

RUN gem update --system

RUN gem install bundler \
                brakeman \
                dependenci \
                sandi_meter \
                rails_best_practices \
                rubocop

RUN git clone -b json-output https://github.com/sosedoff/flog.git && \
    cd flog && \
    gem install hoe && rake gem && gem install pkg/flog-4.2.0.gem && \
    rm -rf /flog

# Adds main reporter script
ADD data/codescout /usr/local/bin/codescout

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

# Add default config with a few small modifications
ADD data/rails_best_practices.yml /etc/rails_best_practices.yml
