FROM ubuntu:12.04
MAINTAINER Dan Sosedoff "dan@doejo.com"

RUN apt-get update

RUN echo "LC_ALL=\"en_US.UTF-8\"" >> /etc/default/locale
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

RUN apt-get install -y wget curl python-software-properties
RUN add-apt-repository -y ppa:git-core/ppa
RUN apt-get install -y git-core

RUN gem install sandi_meter \
                simplecov \
                flog \
                cane \
                brakeman \
                ruby-lint \
                rubocop \
                rails_best_practices