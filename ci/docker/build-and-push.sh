#!/bin/sh
set -eu
SCRIPT_DIR="$(realpath "$(dirname -- "$0")")"; readonly SCRIPT_DIR;
print() { printf "%b%b" "${1-""}" "${2-"\\n"}"; }
stderr() { print "$@" 1>&2; }
reportError() { stderr "$2"; return "$1"; }

commandv() { command -v "$1" || reportError "$?" "Executable '$1' not found"; }


VERSION="$(git describe --tags --match="[vV][[:digit:]]*" --always HEAD)"


if [ -z "${VERSION+x}" ]; then
	reportError 1 "VERSION missing"
fi

docker compose build
docker compose push
