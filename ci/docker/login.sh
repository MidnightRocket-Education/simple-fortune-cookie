#!/bin/sh
set -eu

print() { printf "%b%b" "${1-""}" "${2-"\\n"}"; }
stderr() { print "$@" 1>&2; }
reportError() { stderr "$2"; return "$1"; }
commandv() { command -v "$1" || reportError "$?" "Executable '$1' not found"; }

docker="$(commandv docker)"

if [ -z "${DOCKER_PASSWORD+x}" ]; then
	reportError 1 "DOCKER_PASSWORD missing"
fi
if [ -z "${DOCKER_USER+x}" ]; then
	reportError 1 "DOCKER_USER missing"
fi



echo "$DOCKER_PASSWORD" | docker login "ghcr.io" -u "$DOCKER_USER" --password-stdin
