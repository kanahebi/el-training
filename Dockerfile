#Node.js & Yarn
FROM node:18.7.0-alpine as node

RUN apk add --no-cache bash curl && \
    curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 1.22.19


#Ruby & Bundler & postgresql-client
FROM ruby:3.1.2-alpine

COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /opt/yarn-* /opt/yarn
RUN ln -fs /opt/yarn/bin/yarn /usr/local/bin/yarn
RUN apk add --no-cache git build-base libxml2-dev libxslt-dev postgresql-dev postgresql-client tzdata bash less vim && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

ENV APP_ROOT /el_training
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

ENV LANG=ja_JP.UTF-8 \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    EDITOR=vim
RUN gem update --system && \
    gem install --no-document bundler:2.3.10
RUN bundle config set force_ruby_platform true
