FROM ubuntu:12.04
MAINTAINER Dan Sosedoff "dan@doejo.com"

RUN apt-get update

RUN echo "LC_ALL=\"en_US.UTF-8\"" >> /etc/default/locale
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

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

RUN git clone https://github.com/sstephenson/ruby-build.git && \
    ./ruby-build/bin/ruby-build "2.1.1" "/usr/local" && \
    rm -rf ./ruby-build

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

ADD codescout /usr/local/bin/codescout
