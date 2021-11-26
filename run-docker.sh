#!/usr/bin/env bash

# Change `$(pwd)/workspace` to wherever you store your code, notebooks, etc.
# Alternatively, you can add several mount points within the target's
# workspace directory.

# Default port is 8888, can change it by running this script
# with the desired port number as the first argument.
PORT=${1:-8888}

docker run \
  -i -t \
  -p "$PORT":"$PORT" \
  --mount type=bind,source="$(pwd)/workspace",target="/home/user/workspace" \
  my_conda_docker:latest \
  /bin/bash -c \
  "jupyter notebook --ip='*' --port=$PORT --no-browser --allow-root"
