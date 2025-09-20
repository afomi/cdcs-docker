# syntax=docker/dockerfile:1.6

ARG RUBY_VERSION=3.3.0

FROM ruby:${RUBY_VERSION}-slim AS app

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential git libpq-dev curl \
  && rm -rf /var/lib/apt/lists/*

ENV APP_HOME=/app
WORKDIR ${APP_HOME}

ENV RAILS_ENV=production \
    BUNDLE_WITHOUT=development:test \
    BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    PATH=/bundle/bin:${PATH}

COPY services/rails_app ${APP_HOME}

RUN bundle install --jobs=$(nproc) --retry=3

RUN mkdir -p tmp/pids

ENTRYPOINT ["./bin/docker-entrypoint.sh"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
