FROM ubuntu:12.04
MAINTAINER Dan Sosedoff "dan@doejo.com"

RUN apt-get update

RUN echo "LC_ALL=\"en_US.UTF-8\"" >> /etc/default/locale

RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

RUN apt-get install -y \
  wget \
  curl \
  git-core \
  autoconf \
  binutils \
  bison \
  build-essential \
  checkinstall \
  openssl \
  sqlite3 \
  ncurses-dev \
  zlib1g \
  zlib1g-dev \
  libssl1.0.0 \
  libssl-dev \
  libcurl4-openssl-dev \
  libffi-dev \
  libgdbm-dev \
  libicu-dev \
  libncurses5-dev \
  libreadline-dev \
  libreadline6-dev \
  libssl-dev \
  libxml2 \
  libxml2-dev \
  libxslt-dev \
  libxslt1-dev \
  libyaml-dev \
  libmysqlclient-dev \
  libpq-dev \
  libsqlite3-dev \
  libqt4-dev \
  freetds-dev \
  freetds-bin \
  libfontconfig1

RUN git clone https://github.com/sstephenson/ruby-build.git && \
    ./ruby-build/bin/ruby-build "2.1.1" "/usr/local" && \
    rm -rf ./ruby-build && \
    rm /tmp/ruby-build*

RUN echo "gem: --no-rdoc --no-ri" >> /usr/local/etc/gemrc

RUN gem update --system

RUN gem install bundler \
                brakeman \
                dependenci \
                sandi_meter \
                rails_best_practices

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