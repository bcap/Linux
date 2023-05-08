# Linux

Utility to run a customized linux shell through docker. Used mostly for experiments where I need a fresh linux host/container. Several tools and language compilers are already installed by default.

Commands:

* `make start` will start the container
* `make shell` will log in into the container. Can be used multiple times to have multiple sessions logged in.
* `make stop` will stop the container. Container state is preserved
* `make status` prints the container status
* `make clean` will stop the container (if running), remove the container and remove its image. This will not remove build caches though.

You can combine make targets:
* `make start shell` will guarantee that a container is up and running and log into it
* `make clean start shell` will always log into a clean, fresh container