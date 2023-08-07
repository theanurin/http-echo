[![Docker Image Version](https://img.shields.io/docker/v/thedetukov/echo-http?sort=date&label=Version)](https://hub.docker.com/r/thedetukov/echo-http/tags)
[![Docker Image Size](https://img.shields.io/docker/image-size/thedetukov/echo-http?label=Image%20Size)](https://hub.docker.com/r/thedetukov/echo-http/tags)
[![Docker Pulls](https://img.shields.io/docker/pulls/thedetukov/echo-http?label=Pulls)](https://hub.docker.com/r/thedetukov/echo-http)
[![Docker Stars](https://img.shields.io/docker/stars/thedetukov/echo-http?label=Docker%20Stars)](https://hub.docker.com/r/thedetukov/echo-http)

# HTTP-ECHO

## Using `Dockerfile`

Docker creates an image to change the background-color of your application in the browser

# Image reason

* Changed background color

# Spec

## Environment variables

This variables passes the names of the color to change background color

* `ECHO_BG_COLOR`

## Expose ports

* `tcp/8080` - echo-http listening endpoint

## Volumes

* No any volumes

# Inside

* http-echo v0.0.2

# Build and Launch

```shell
docker build \
  --tag echo \
  --file docker/Dockerfile \
  .

docker run --rm --interactive --tty \
  --env "ECHO_PORT=8080" \
  --env "ECHO_BG_COLOR=#ff0000" \
  --publish 8080:8080 \
  echo
```

## Services

Service     | Port | Usage
------------|------|------
HTTP-ECHO   | 8080 | When using `http-echo`, visit `http://localhost:8080` in your browser

# Support

* Maintained by: [Dmitry Detukov](https://detukov.name/)
