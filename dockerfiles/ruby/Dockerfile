FROM codecheck/base
MAINTAINER Dan Sosedoff "dan@doejo.com"

RUN git clone https://github.com/sstephenson/ruby-build.git && \
    ./ruby-build/bin/ruby-build "2.1.1" "/usr/local" && \
    rm -rf ./ruby-build

RUN echo "gem: --no-rdoc --no-ri" >> /usr/local/etc/gemrc
RUN gem update --system && gem install bundler