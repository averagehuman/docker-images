
SHELL := /bin/bash

include env.properties

.PHONY: build
build:
	@sed -i "s/^RUN locale-gen .*/RUN locale-gen $(TAG).$(ENCODING)/" Dockerfile
	@sed -i "s/^ENV LANG .*/ENV LANG $(TAG).$(ENCODING)/" Dockerfile
	@sed -i "s/^ENV LC_ALL .*/ENV LC_ALL $(TAG).$(ENCODING)/" Dockerfile
	@docker build --tag=$(NAME) --force-rm --no-cache=$(NO_CACHE) .

.PHONY: exists
exists:
	@source ../etc/docker/common.sh && fail_if_image_exists "$(NAME)" "To delete the image run 'make rmi'"

.PHONY: rmi
rmi:
	@source ../etc/docker/common.sh && remove_image "$(NAME)"

.PHONY: shell
shell:
	@docker run -i -t --rm -v /srv/www:/srv/www $(NAME) /bin/bash

.PHONY: fresh
fresh: rmi build

