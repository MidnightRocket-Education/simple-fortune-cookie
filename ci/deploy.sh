#!/bin/sh
set -eu
print() { printf "%b%b" "${1-""}" "${2-"\\n"}"; }
stderr() { print "$@" 1>&2; }
reportError() { stderr "$2"; return "$1"; }


if [ -z "${KUBECONFIG+x}" ]; then
	reportError 1 "Missing KUBECONFIG env variable"
fi


ACTION="${1:-"apply"}" # Default action is to apply


case "$ACTION" in
	"apply" | "delete" )
		: # do nothing
		;;
	* )
		reportError 1 "'$ACTION' invalid action. Use either 'apply' or 'delete'"
		;;
esac




kubectl "$ACTION" \
	-f ./kubernetes-configurations/backend \
	-f ./kubernetes-configurations/frontend \
	-f ./kubernetes-configurations/database
