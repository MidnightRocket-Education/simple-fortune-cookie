FROM golang:1.23.0-bookworm AS builder

WORKDIR /app
COPY . /app

RUN go mod download && go mod verify
RUN cd /app && go build -o goapp


# FROM ubuntu:latest
FROM golang:1.23.0-bookworm

WORKDIR /app
COPY --from=builder /app/goapp /app/

EXPOSE 8080

ENTRYPOINT ["./goapp"]
