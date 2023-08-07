[![Docker Image Version](https://img.shields.io/docker/v/theanurin/http-echo?sort=date&label=Version)](https://hub.docker.com/r/theanurin/http-echo/tags)
[![Docker Image Size](https://img.shields.io/docker/image-size/theanurin/http-echo?label=Image%20Size)](https://hub.docker.com/r/theanurin/http-echo/tags)
[![Docker Pulls](https://img.shields.io/docker/pulls/theanurin/http-echo?label=Pulls)](https://hub.docker.com/r/theanurin/http-echo)
[![Docker Stars](https://img.shields.io/docker/stars/theanurin/http-echo?label=Docker%20Stars)](https://hub.docker.com/r/theanurin/http-echo)

# HTTP-ECHO

## Using `Dockerfile`

Docker creates an image to change the background-color of your application in the browser

# Image reason

* Changed background color

# Spec

## Environment variables

* `ECHO_BG_COLOR`- This variables passes the names of the color to change background color
* `ECHO_PORT`- This variables passes the names of the port

## Expose ports

* `tcp/8080` - http-echo listening endpoint

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

# Support

* Maintained by: [Dmitry Detukov](https://t.me/thedem_on), [Max Anurin](https://anurin.name/)
