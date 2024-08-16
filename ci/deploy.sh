#!/bin/sh
kubectl --kubeconfig $1 apply -f ./kubernetes-configurations/backend
kubectl --kubeconfig $1 apply -f ./kubernetes-configurations/frontend
kubectl --kubeconfig $1 apply -f ./kubernetes-configurations/database
