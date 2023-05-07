# Linux

Utility to run a customized linux shell through docker. Used mostly for experiments where I need a fresh linux host/container. Several tools and language compilers are already installed by default.

Commands:

* `make shell` will start a container (if there is none running) and log into it. Subsequent calls to `make shell` will log you back to the same container. Use `make clean-shell` to log to a fresh container.

* `make clean` will stop the container (if running), remove the container and remove its image. This will not remove build caches though.

* `make clean-shell` will always log into a fresh container. It is the combination of the `clean` and `shell` targets.