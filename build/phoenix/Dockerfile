# syntax=docker/dockerfile:1.6

ARG ELIXIR_VERSION=1.15.7
ARG OTP_VERSION=26.2
ARG DEBIAN_VERSION=bookworm-20240318

FROM hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION} AS build

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential git \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
ENV MIX_ENV=prod
ENV LANG=C.UTF-8

RUN mix local.hex --force && mix local.rebar --force

COPY services/phoenix_app/mix.exs ./mix.exs
COPY services/phoenix_app/mix.lock* ./
COPY services/phoenix_app/config ./config

RUN mix deps.get --only prod \
  && mix deps.compile

COPY services/phoenix_app/lib ./lib
COPY services/phoenix_app/priv ./priv

RUN mix compile
RUN mix release --overwrite

FROM debian:${DEBIAN_VERSION} AS runtime

RUN apt-get update \
  && apt-get install -y --no-install-recommends libstdc++6 openssl libssl3 libncurses6 ca-certificates \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
ENV LANG=C.UTF-8
ENV MIX_ENV=prod

RUN addgroup --system phoenix \
  && adduser --system --ingroup phoenix --home /app --no-create-home phoenix

COPY --from=build /app/_build/prod/rel/phoenix_app ./phoenix_app
RUN chown -R phoenix:phoenix /app
USER phoenix

ENV PHX_SERVER=true
ENTRYPOINT ["/app/phoenix_app/bin/phoenix_app"]
CMD ["start"]
