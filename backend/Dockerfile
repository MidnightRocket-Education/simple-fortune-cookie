FROM golang:1.22.6-alpine AS builder

WORKDIR /app
COPY . /app

RUN go build -o backend




FROM alpine AS deploy
COPY --from=builder /app/backend /

ENTRYPOINT ["/backend"]


EXPOSE 9000
