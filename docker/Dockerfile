FROM node:18-alpine3.18 AS build

WORKDIR /build
COPY bin/ bin/
COPY src/ src/
COPY package.json package.json
COPY package-lock.json package-lock.json
COPY tsconfig.json tsconfig.json

RUN set -ex \
  && npm install \
  && npm run build

EXPOSE 3000

ENTRYPOINT ["node", "/build/bin/app.js"]
