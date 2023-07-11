# HTTP-ECHO

Using this program you can change the background color of your application in browser.
A simple Dart HTTP server using [package:shelf](https://pub.dev/packages/shelf).

- Listens on "any IP" (0.0.0.0) instead of loop-back (localhost, 127.0.0.1) to
  allow remote connections.
- Defaults to listening on port `8080`, but this can be configured by setting
  the `PORT` environment variable.
- Includes `Dockerfile` for easy containerization

## Get Started

```shell
git clone git@github.com:theanurin/http-echo.git

cd http-echo

git checkout src-dart
```

To run this server locally, run as follows:

```shell
dart run bin/server.dart
```

Run the Docker image:

```shell
  docker run --rm --interactive --tty \
  --env "ECHO_BG_COLOR=#ff0000" \
  --publish 8080:8080 \
  echo
```
