# Uses alpine:3.9 underneath.
FROM ruby:2.5.5-alpine

WORKDIR /app

RUN apk --update add --virtual \
      build_deps \
      build-base \
      ruby-dev \
      libc-dev \
      linux-headers \
      openssl-dev \
      postgresql-dev \
      libxml2-dev \
      libxslt-dev \
      bash \
      make \
      curl \
      curl-dev \
      jq

COPY Gemfile* ./
RUN bundle install --without=development

COPY . .

CMD ["bundle", "exec", "rake", "serve"]
