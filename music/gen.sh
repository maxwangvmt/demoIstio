#!/bin/bash

istioctl kube-inject -f deploy.music.yaml > injected.music.yaml
