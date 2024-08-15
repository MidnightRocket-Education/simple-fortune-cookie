FROM golang:1.22.6-alpine AS builder

WORKDIR /app
COPY . /app

RUN go mod download && go mod verify
RUN cd /app && go build -o goapp


# FROM ubuntu:latest
FROM alpine

WORKDIR /app
COPY --from=builder /app/goapp /app/
COPY --from=builder /app/static /app/static
COPY --from=builder /app/templates /app/templates

EXPOSE 8080

ENTRYPOINT ["./goapp"]
