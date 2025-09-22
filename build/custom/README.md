# Custom Image Overlay

This directory holds the scaffolding for extending the base CDCS Docker image with project-specific tweaks. The Docker build expects the parent image name, tag, and Django project name to be supplied via `BASE_IMAGE_NAME`, `BASE_IMAGE_VERSION`, and `PROJECT_NAME` build args.

## Dockerfile
- Switches to root so it can install extra system packages defined in `packages.txt` (one apt package per line).
- Installs additional Python dependencies listed in `requirements.txt` using `pip`.
- Appends any Django overrides from `settings.py` into the project’s `settings.py` inside the image (`$DOCKYARD_SRVPROJ/${PROJECT_NAME}/settings.py`).
- Returns control to the unprivileged `cdcs` user before exiting.

## Compose helper
`docker-compose.yml` rebuilds the customized image locally and tags it as `${IMAGE_NAME}:${IMAGE_VERSION}` while threading through the base-image arguments. Run it from this directory when you need to bake the overlay:

```sh
IMAGE_NAME=cdcs-custom IMAGE_VERSION=latest \
BASE_IMAGE_NAME=cdcs BASE_IMAGE_VERSION=stable \
PROJECT_NAME=cdcs python \
docker-compose build
```

## Customization workflow
1. Copy the sample files under `examples/` to the root of this folder if you need guidance (`example_packages.txt`, `example_requirements.txt`, `example_settings.py`).
2. Edit `packages.txt`, `requirements.txt`, and `settings.py` to declare the packages and settings you want baked into the image. Leave files blank when they are not needed.
3. Rebuild the image with `docker-compose build` (or via the broader stack) and re-deploy as needed.

All files remain ASCII plaintext so they can be tracked and merged easily.
