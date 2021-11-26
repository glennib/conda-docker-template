#!/bin/bash --login
set -e

conda init
conda activate conda_environment

exec "$@"
