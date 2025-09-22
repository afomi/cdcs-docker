# syntax=docker/dockerfile:1.6

ARG ELIXIR_VERSION=1.18.4
ARG OTP_VERSION=28.0.1
ARG DEBIAN_VERSION=bookworm-20250630-slim
ARG PHOENIX_APP_PATH=services/cdcs_ex
ARG PHOENIX_RELEASE=phoenix_app

FROM hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION} AS build

ARG PHOENIX_APP_PATH

RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential git nodejs npm \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
ENV MIX_ENV=prod
ENV LANG=C.UTF-8

RUN mix local.hex --force && mix local.rebar --force

COPY ${PHOENIX_APP_PATH}/mix.exs ./mix.exs
COPY ${PHOENIX_APP_PATH}/mix.lock* ./
COPY ${PHOENIX_APP_PATH}/config ./config

RUN mix deps.get --only prod \
  && mix deps.compile

COPY ${PHOENIX_APP_PATH}/lib ./lib
COPY ${PHOENIX_APP_PATH}/priv ./priv
COPY ${PHOENIX_APP_PATH}/assets ./assets

# Install Node dependencies when provided (supports apps managing assets via npm)
RUN if [ -f assets/package.json ]; then cd assets && npm install; fi

RUN mix compile

# Prepare toolchain binaries (tailwind, esbuild) that Phoenix expects
RUN mix assets.setup

# compile assets
RUN mix assets.deploy

RUN mix release

FROM debian:${DEBIAN_VERSION} AS runtime

ARG PHOENIX_RELEASE=phoenix_app

RUN apt-get update \
  && apt-get install -y --no-install-recommends libstdc++6 openssl libssl3 libncurses6 ca-certificates \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN addgroup --system phoenix \
  && adduser --system --ingroup phoenix --home /app --no-create-home phoenix

COPY --from=build /app/_build/prod/rel/${PHOENIX_RELEASE} ./${PHOENIX_RELEASE}
RUN cat <<'SH' >/entrypoint.sh
#!/bin/sh
set -e
exec "/app/${PHOENIX_RELEASE}/bin/${PHOENIX_RELEASE}" "$@"
SH
RUN chmod +x /entrypoint.sh
RUN chown -R phoenix:phoenix /app
USER phoenix

ENV PHOENIX_RELEASE=${PHOENIX_RELEASE}
ENV PHX_SERVER=true
ENTRYPOINT ["/entrypoint.sh"]
CMD ["start"]
