#!/bin/bash

start_docker() {
  local port="${1}"; shift

  while :; do
    docker run \
        --rm \
        --privilege \
        --publish="${port}:22" \
        --volume=/alloc:/alloc \
        --volume=/var/tmp:/var/tmp \
        local/ninelet "$@"
    sleep 1
  done
}

cd "$(dirname $0)"

date > dummy
docker build --tag=local/ninelet .

for port in $(seq 2201 2209); do
  start_docker "${port}" &
done

for port in $(seq 2210 2219); do
  start_docker "${port}" -d &
done
