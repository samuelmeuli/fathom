# Docker

Fathom provides a [Docker image](../Dockerfile) you can use. You can use it in one of the following ways:

## Building from Docker Hub

The image is available [on Docker Hub](https://hub.docker.com/r/samuelmeuli/fathom). To use it, run `docker run -p 8080:8080 samuelmeuli/fathom:latest`.

## Building from Dockerfile

1. Ensure you have Docker installed.
2. From the project root, build the image with `docker build -t fathom .`.
3. Start the container with `docker run -p 8080:8080 fathom`.

## Building with Docker Compose

Here's an example `docker-compose.yml` file for Fathom:

```yml
version: "3"

services:
  fathom:
    image: samuelmeuli/fathom:latest
    environment:
      - "FATHOM_SERVER_ADDR=:8080"
      - "FATHOM_DATABASE_DRIVER=sqlite3"
      - "FATHOM_DATABASE_NAME=/app/db/fathom.db"
      - "FATHOM_DATABASE_USER=your@email.com"
      - "FATHOM_DATABASE_PASSWORD=your-password"
      - "FATHOM_SECRET=your-secret"
    volumes:
      - /path/to/your/db:/app/db
    restart: always
```

You can execute it by running `docker-compose up`.
