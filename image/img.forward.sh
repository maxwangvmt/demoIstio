#!/bin/bash


localport=19527
destport=9527
namespace=default
kubectl -n $namespace port-forward $(kubectl -n $namespace get pod -l app=image-app-pods -o jsonpath='{.items[0].metadata.name}') $localport:$destport 

