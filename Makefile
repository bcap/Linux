build:
	@docker build -t bcap/linux/alpine .

shell:
	@( \
		docker start linux-shell 2> /dev/null && \
		echo "=> re-attached to a previously stopped container. Use make clean-shell to log into a fresh container" \
	) || ( \
		echo "=> container not present, building a new one" && \
		$(MAKE) build && \
		echo "=> attached to a new container" && \
		docker run --detach --name linux-shell --cap-add SYS_ADMIN --ulimit=memlock=8388608 -it bcap/linux/alpine /bin/zsh > /dev/null \
	)
	@docker attach linux-shell

clean:
	@docker kill linux-shell > /dev/null 2>&1 && echo container linux-shell killed || true
	@docker container rm linux-shell > /dev/null 2>&1 && echo container linux-shell removed || true
	@docker image rm bcap/linux/alpine > /dev/null 2>&1 && echo image bcap/linux/alpine removed || true

clean-shell: clean shell