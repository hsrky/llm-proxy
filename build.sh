#!/usr/bin/env bash
podman build -v /dev/urandom:/dev/urandom -v /dev/random:/dev/random -t llm-proxy .
