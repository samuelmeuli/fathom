FROM node:12-alpine3.11 AS asset-builder
WORKDIR /app
COPY package*.json ./
COPY gulpfile.js ./
COPY assets/ assets/
RUN npm install && NODE_ENV=production node_modules/gulp/bin/gulp.js

FROM golang:1.14-alpine3.11 AS binary-builder
RUN apk add --no-cache --update build-base git
RUN go get -u github.com/gobuffalo/packr/packr
WORKDIR /go/src/github.com/samuelmeuli/fathom
COPY . /go/src/github.com/samuelmeuli/fathom
COPY --from=asset-builder /app/assets/build assets/build
RUN make install-tools docker

FROM alpine:3.11
EXPOSE 8080
HEALTHCHECK --retries=10 CMD ["wget", "-qO-", "http://localhost:8080/health"]
RUN apk add --no-cache --update bash ca-certificates
WORKDIR /app
COPY --from=binary-builder /go/src/github.com/samuelmeuli/fathom/fathom .
CMD ["./fathom", "server"]
