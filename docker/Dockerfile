FROM node:18-alpine3.18 AS builder

WORKDIR /build
COPY src/ src/
COPY package.json package.json
COPY package-lock.json package-lock.json
COPY tsconfig.json tsconfig.json

RUN npm install
RUN npm run build

RUN mkdir -p /dist/usr/local/echo-service/
RUN mkdir -p /dist/usr/local/echo-service/bin/
RUN mkdir -p /dist/usr/local/echo-service/src/
RUN cp package.json /dist/usr/local/echo-service/
RUN cp package-lock.json /dist/usr/local/echo-service/
COPY bin/ /dist/usr/local/echo-service/bin/
RUN cp src/*.js /dist/usr/local/echo-service/src/
WORKDIR /dist/usr/local/echo-service/
RUN npm install --production
RUN rm package-lock.json
COPY docker/docker-entrypoint.sh /dist/usr/local/bin/docker-entrypoint-echo.sh

FROM node:18-alpine3.18 AS final
COPY --from=builder /dist /
USER node
ENTRYPOINT ["/usr/local/bin/docker-entrypoint-echo.sh"]
