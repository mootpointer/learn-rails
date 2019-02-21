FROM ruby:2.6
RUN apt-get update -yqq
RUN apt-get install -yqq --no-install-recommends nodejs
COPY . /usr/src/app/
COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN gem install bundler:2.0.1
RUN bundle install
EXPOSE 3000
CMD ["rails", "s", "-b", "0.0.0.0" ]