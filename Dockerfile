FROM youyo/amzn:2016.03
MAINTAINER youyo
RUN yum -y install ruby22* rubygems22* gcc gcc-c++
RUN alternatives --set ruby /usr/bin/ruby2.2
RUN gem install bundler
