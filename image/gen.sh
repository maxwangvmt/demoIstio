#!/bin/bash

istioctl kube-inject -f deploy.image.yaml > injected.image.yaml
