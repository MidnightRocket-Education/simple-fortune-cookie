FROM golang:1.23.0-bookworm
COPY . /app
WORKDIR /app
ENTRYPOINT ["sh"]
