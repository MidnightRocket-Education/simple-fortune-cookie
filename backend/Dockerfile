FROM golang:1.23.0-bookworm AS builder

WORKDIR /app
COPY . /app

RUN go build -o backend




FROM golang:1.23.0-bookworm AS deploy
COPY --from=builder /app/backend /

ENTRYPOINT ["/backend"]


EXPOSE 9000
