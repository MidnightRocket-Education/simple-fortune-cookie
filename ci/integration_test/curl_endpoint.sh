#!/bin/sh
set -eu
print() { printf "%b%b" "${1-""}" "${2-"\\n"}"; }
stderr() { print "$@" 1>&2; }
reportError() { stderr "$2"; return "$1"; }

commandv() { command -v "$1" || reportError "$?" "Executable '$1' not found"; }

_wait_action() { stderr "Sleeping..."; sleep 1; }
until_timeout() {
	_MAX_TRIES="$1"
	shift
	until "$@"; do
		test "$(( _t+=1 ))" -gt "$_MAX_TRIES" && return 124
		_wait_action
	done
}


if [ -z "${KUBECONFIG+x}" ]; then
	reportError 1 "Missing KUBECONFIG env variable"
fi


SERVICE_NAME="${SERVICE_NAME:-"frontend-service"}"
PATHNAME="${PATHNAME:-"healthz"}"
PROTOCOL="${PROTOCOL:-"http://"}"


NODE_PORT="$(kubectl get -o jsonpath='{.spec.ports[0].nodePort}' service "$SERVICE_NAME")"



get_address() {
	ADDRESS="$(kubectl get -o jsonpath='{range .items[*]}{.status.addresses[?(@.type == "ExternalDNS")].address}{"\n"}{end}' nodes | shuf -n 1 -)"
	print "${PROTOCOL}${ADDRESS}:$NODE_PORT/$PATHNAME"
}

fetch() {
	curl -f "$(get_address)"
}


until_timeout 15 fetch
stderr "\nSuccess"
