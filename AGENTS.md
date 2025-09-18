# Repository Guidelines

## Project Structure & Module Organization
The repo is anchored by `build/` and `deploy/`. `build/cdcs` holds the Dockerfile, entrypoints, and pip bundles; `build/custom` extends base images via `packages.txt`, `requirements.txt`, and `settings.py`. Deployment variants live under `deploy/`, with service-specific overlays such as `deploy/mongo` and `deploy/celery`. Shared Docker Compose manifests sit in `build/docker-compose.yml` and `deploy/docker-compose.yml`, while helper scripts like `deploy/docker_migrate.sh` automate post-deployment maintenance.

## Build, Test, and Development Commands
Run image builds from the appropriate directory. Use `cd build && docker-compose build` for standard images, or `cd build/custom && docker-compose build --no-cache` after editing `.env` and override files. Validate compose syntax with `docker-compose config`. For local deployments, `cd deploy && docker-compose up -d` spins up the stack; `docker-compose down -v` removes data volumes when you need a clean slate.

## Coding Style & Naming Conventions
Compose files and YAML overlays use two-space indentation and lowercase keys. Shell scripts under `deploy/` target POSIX sh—prefer portable syntax and guard files with `set -euo pipefail`. Name environment variables in uppercase with underscores, mirroring existing `.env` entries. When adding new scripts, follow the `docker_*.sh` naming pattern.

## Testing Guidelines
There is no automated CI; contributors validate changes locally. Run `docker-compose config` in both `build/` and `deploy/` to catch schema issues. For functional checks, launch the stack and exercise critical paths, then run `docker-compose logs -f cdcs` to confirm Django boots cleanly. If you add optional services (MongoDB, Celery, Elasticsearch), ensure their overlays come up without errors.

## Commit & Pull Request Guidelines
Follow the existing log style: short imperative summaries with optional context in parentheses, for example `Add nginx overlay (#52)`. Squash trivial fixups before opening a PR. Each PR should describe configuration changes, include updated `.env` keys or sample commands, and link associated issues. Provide screenshots or command output when altering deployment behavior, and call out any manual steps required for operators.

## Configuration Tips
Never commit real secrets; keep environment values in `.env` and document defaults in the README. When introducing a new service, update the README and sample `.env` entries so downstream teams can reproduce your setup.
