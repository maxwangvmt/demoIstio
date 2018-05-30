#!/bin/bash


localport=18080
destport=8080
namespace=default
kubectl -n $namespace port-forward $(kubectl -n $namespace get pod -l app=music-app-pods -o jsonpath='{.items[0].metadata.name}') $localport:$destport 

