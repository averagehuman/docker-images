
SHELL := /bin/bash

include env.properties

.PHONY: exists
exists:
	@source ../etc/docker/common.sh && fail_if_image_exists "$(NAME)" "To delete the image run 'make rmi'"

.PHONY: rmi
rmi:
	@source ../etc/docker/common.sh && remove_image "$(NAME)"

.PHONY: build
build: exists
	@docker build --tag=$(NAME) --force-rm $(DOCKER_SOURCE)

.PHONY: shell
shell:
	@docker run -i -t --rm $(NAME) /bin/bash

.PHONY: fresh
fresh: rmi build

