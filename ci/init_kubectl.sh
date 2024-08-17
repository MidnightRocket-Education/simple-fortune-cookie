#!/bin/sh
set -eu
print() { printf "%b%b" "${1-""}" "${2-"\\n"}"; }
stderr() { print "$@" 1>&2; }
reportError() { stderr "$2"; return "$1"; }

commandv() { command -v "$1" || reportError "$?" "Executable '$1' not found"; }

if [ -z "${KUBECONFIG_CONTENT+x}" ]; then
	reportError 1 "Missing KUBECONFIG_CONTENT env variable"
fi

if [ -z "${KUBECONFIG_CONTENT}" ]; then
	reportError 1 "KUBECONFIG_CONTENT is empty!"
fi

if [ -z "${KUBECONFIG+x}" ]; then
	reportError 1 "Missing KUBECONFIG env variable"
fi


print "$KUBECONFIG_CONTENT" | base64 -d > "$KUBECONFIG"


print "::group::Environment" # https://github.com/actions/toolkit/blob/main/docs/commands.md#group-and-ungroup-log-lines

print "WORKSTATION_ID: ${WORKSTATION_ID:-"UNKOWN"}"
print "ENVIRONMENT: ${ENVIRONMENT:-"UNKOWN"}"

stat --printf="Kubeconfig size: %s\n" "$KUBECONFIG"

print "KUBECONFIG_CONTENT length: ${#KUBECONFIG_CONTENT}"
print "Current context: $(kubectl config current-context)"

print "::endgroup::"
