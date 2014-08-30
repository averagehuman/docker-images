
SHELL := /bin/bash

include build.properties

.PHONY: requirements
requirements:
	@if [ ! -e vendor ]; then \
		mkdir -p vendor; \
		for pkg in $$(grep -v "://\|^$$\|^#" requirements.txt); do \
			pip install -d vendor --no-use-wheel $$pkg \
		;done \
	;fi

.PHONY: build
build: requirements
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

.PHONY: run
run:
	@docker run -d -P --name=myapp -v /srv/www:/srv/www $(NAME)

.PHONY: purge
purge:
	@rm -rf vendor

.PHONY: fresh
fresh: rmi purge build

