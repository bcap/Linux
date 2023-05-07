# Linux

Utility to run a customized linux shell through docker. Used mostly for experiments where I need a fresh linux host/container. Several tools and language compilers are already installed by default

Commands:

* `make shell` will start a container if there is none and log into it. Subsequent calls to `make shell` will log you back to the same container

* `make clean` will remove the container. The next call to `make shell` will start a fresh container