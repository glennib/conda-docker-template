# conda-docker-template

Template for running a conda/notebook server in a docker container.

## Building

A build script is provided, just run
```shell script
./build-docker.sh
```
to build the docker image on your computer.
This can take a while the first time, especially the commands
that update conda and create your conda environment.

## Running

To start the notebook, a run script is provided:
```shell script
./run-docker.sh
```
Open the URL which is printed last and starts with `http://127.0.0.1` to
open the Jupyter notebook instance.
This script mounts the example `workspace` directory to the container,
and lets you keep changes when the container is destroyed.

## Mounting code from different places

You may want to include code from other locations on your computer.
Replace or append to the `--mount` option in the `run-docker.sh` script.
Example:
```sh
# snipped
docker run \
  -t \
  -p "$PORT":"$PORT" \
  --mount type=bind,source="/home/host_user/src/my_code",target="/home/user/workspace/my_code" \
  --mount type=bind,source="/home/host_user/src/my_library",target="/home/user/workspace/my_library" \
  my_conda_docker:latest \
# snipped
```

## Custom Python modules

To work with custom Python modules, I recommend modifying the Dockerfile
to either install it as a `pip` package if you have packaged your module,
or mount it as described above, and edit the `setup/entrypoint.sh` to add
that directory to the Python path, or edit the Dockerfile to add that
directory to the Python path.

## Install or build dependencies

If you have dependencies which are not available on `pip`, it's possible
to modify the `Dockerfile` to install them any way you like.
