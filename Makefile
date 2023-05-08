build:
	@docker build -t bcap/linux/alpine .

start:
	@docker ps -a -f name=linux-shell --format '{{.State}}' | grep -q running && echo container linux-shell already running || \
	(docker start linux-shell >/dev/null 2>&1 && echo container linux-shell started) || \
	($(MAKE) build && docker run --detach --name linux-shell --cap-add SYS_ADMIN --ulimit=memlock=8388608 -it bcap/linux/alpine sleep inf && echo container linux-shell created and started)

stop:
	@docker kill linux-shell >/dev/null 2>&1 && echo container linux-shell stopped || echo container linux-shell not running

shell:
	@docker exec -it linux-shell /bin/zsh

status:
	@docker ps -a -f name=linux-shell

clean: stop
	@docker container rm linux-shell > /dev/null 2>&1 && echo container linux-shell removed || true
	@docker image rm bcap/linux/alpine > /dev/null 2>&1 && echo image bcap/linux/alpine removed || true