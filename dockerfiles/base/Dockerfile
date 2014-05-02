FROM ubuntu:12.04
MAINTAINER Dan Sosedoff "dan@doejo.com"

RUN apt-get update

RUN echo "LC_ALL=\"en_US.UTF-8\"" >> /etc/default/locale
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

RUN apt-get install -y wget curl python-software-properties
RUN add-apt-repository -y ppa:git-core/ppa
RUN apt-get install -y git-core

RUN apt-get install -y \
  autoconf \
  binutils \
  bison \
  build-essential \
  checkinstall \
  openssl \
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
  libyaml-dev

RUN apt-get install -y \
  sqlite3 \
  libmysqlclient-dev \
  libpq-dev \
  libsqlite3-dev \
  libqt4-dev \
  freetds-dev \
  freetds-bin \
  libfontconfig1