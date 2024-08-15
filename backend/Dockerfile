FROM golang:1.23.0-bookworm AS builder

WORKDIR /app
COPY . /app

RUN go build -o frontend








#FROM golang:1.23.0-alpine AS deploy
#COPY --from=builder /app/frontend /

ENTRYPOINT ["/app/frontend"]


EXPOSE 9000
