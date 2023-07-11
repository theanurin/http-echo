ARG GOOGLE_DART_VERSION=2.16-dev
ARG ALPINE_VERSION=3.18.2

FROM mikefarah/yq AS yq

FROM dart:3.1.0-262.1.beta-sdk AS builder
ARG BUILD_TAG_VERSION
COPY --from=yq /usr/bin/yq /usr/bin/yq
WORKDIR /build
COPY pubspec.yaml pubspec.yaml
RUN \
    set -e; \
    PROJ_VERSION="$(yq -r '.version' pubspec.yaml)"; \
    set +e; \
    if [ -n "${BUILD_TAG_VERSION}" ]; then \
      if [ "${BUILD_TAG_VERSION}" != "${PROJ_VERSION}" ]; then \
        echo "Project version '${PROJ_VERSION}' is not same to tag version '${BUILD_TAG_VERSION}'. Cannot continue. Try to set correct project before tag creation." >&2; \
        exit 1; \
      fi; \
    fi;
RUN mkdir -p /dist/usr/local/http-echo/
RUN mkdir -p /dist/usr/local/bin/
COPY bin/server.dart /build/bin/server.dart
COPY lib /build/lib
COPY pubspec.lock /build/pubspec.lock
RUN dart pub get
RUN dart compile exe --output /dist/usr/local/http-echo/http-echo-service bin/server.dart
COPY docker/app.logo /dist/usr/local/http-echo/http-echo-service.logo
COPY docker/docker-entrypoint.sh /dist/usr/local/bin/docker-entrypoint-echo.sh

FROM debian:bullseye-slim
COPY --from=builder /runtime/ /
COPY --from=builder /dist/ /
ENV ECHO_BG_COLOR=
ENV ECHO_PORT=
ENTRYPOINT ["/usr/local/bin/docker-entrypoint-echo.sh"]
