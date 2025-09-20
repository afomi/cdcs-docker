#!/bin/sh
set -euo pipefail

if [ -f Gemfile ]; then
  if ! bundle check >/dev/null 2>&1; then
    bundle install
  fi
fi

if [ -f ./bin/rails ]; then
  ./bin/rails db:prepare >/dev/null 2>&1 || true
fi

exec "$@"
