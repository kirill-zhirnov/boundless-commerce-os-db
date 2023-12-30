# Database for Boundless Commerce

## Docker Image

There are 2 required environment variables:

- `POSTGRES_PASSWORD`
- `DELIVERY_VIEW_DB_PASS`

## Launching with Docker-Compose:

An example of `docker-compose.yml`:

```
version: '3.6'
services:
  db:
    image: kirillzh87/boundless-commerce-db:latest
    environment:
      POSTGRES_PASSWORD: "${POSTGRES_PASSWORD}"
      DELIVERY_VIEW_DB_PASS: "${DELIVERY_VIEW_DB_PASS}"
    healthcheck:
      test: pg_isready -U postgres
      interval: 10s
      timeout: 5s
      retries: 5
    restart: unless-stopped
```

## Launching DB natively

If you want to run DB naively - execute queries from `./docker/postgres/docker-startup.sh` - Don't forget to specify 
environment variables!

