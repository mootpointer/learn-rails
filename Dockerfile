FROM ruby:2.6-alpine
RUN \
  apk update && \
  apk add bash py-pip nodejs postgresql-libs tzdata && \
  apk add --virtual=build gcc libffi-dev musl-dev openssl-dev python-dev postgresql-dev make && \
  pip --no-cache-dir install -U pip && \
  pip --no-cache-dir install azure-cli
COPY . /usr/src/app/
COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN gem install bundler:2.0.1
RUN bundle install --deployment --without development test && \
    bundle exec rails assets:precompile
RUN apk del --purge build
EXPOSE 80
CMD ["bundle", "exec", "rails", "s", "-p", "80", "-b", "0.0.0.0", "-e", "production"]