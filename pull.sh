#!/bin/bash

set -e

if [ $# -ne 1 ]; then
  echo "usage: pull.sh images.txt"
  exit 1
fi

while IFS='' read -r image || [[ -n "$image" ]]; do
  src="${image}"
  target="${DOCKER_CI_REGISTRY}/lixinio/$image"
  echo "Pulling "${src}" ..."
  docker pull "${src}"
  docker tag "${src}" "${target}"
  docker push "${target}"
done < "$1"
