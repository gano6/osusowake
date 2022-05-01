FROM ruby:3.1.1

ENV LANG C.UTF-8
ENV APP_ROOT /osusowake
ENV BUNDLE_JOBS 4
ENV BUNDLER_VERSION 2.2.25

RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT
RUN mkdir -p tmp/sockets

COPY Gemfile $APP_ROOT/Gemfile
COPY Gemfile.lock $APP_ROOT/Gemfile.lock

RUN gem install bundler -v $BUNDLER_VERSION
RUN bundle -v
RUN bundle install

COPY . $APP_ROOT

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

VOLUME $APP_ROOT/public
VOLUME $APP_ROOT/tmp

EXPOSE 3000

CMD bash -c "rm -f tmp/pids/server.pid && bundle exec puma -C config/puma.rb"
