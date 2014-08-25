
SHELL := /bin/bash

include build.properties
include env.properties

.PHONY: nginx
nginx:
	@if [ ! -e "$(NGINX_PREFIX)" ]; then \
		cd $(NGINX_SUPPORT) && ./install.sh \
		--version=$(NGINX_VERSION) \
		--prefix=$(NGINX_PREFIX) \
		--with-http_ssl_module \
		--without-http_scgi_module \
		--without-http_ssi_module \
		--add-module=$(NGINX_SUPPORT)/ngx_devel_kit-0.2.19 \
		--add-module=$(NGINX_SUPPORT)/ngx_http_set_hash-0.2.1 \
		--add-module=$(NGINX_SUPPORT)/echo-nginx-module-0.55 \
		--add-module=$(NGINX_SUPPORT)/vkholodkov-nginx-upload-module-2.2-ed996c4f7f && \
		rm -rf $(DOCKER_SOURCE)/nginx \
	;fi
	@if [ ! -e $(DOCKER_SOURCE)/nginx ]; then \
		cp -r $(NGINX_PREFIX) $(DOCKER_SOURCE)/nginx \
	;fi
	@sed -e "s;%PREFIX%;$(NGINX_PREFIX);g" nginx.conf.template > $(DOCKER_SOURCE)/nginx/conf/nginx.conf


.PHONY: uwsgi
uwsgi:
	@if [ ! -e "$(UWSGI_LOCAL_BINARY)" ]; then \
		cd $(UWSGI_SUPPORT) && ./install.sh \
		--version=$(UWSGI_VERSION) \
		--binary-path=$(UWSGI_LOCAL_BINARY) \
	;fi

.PHONY: image
image: nginx uwsgi
	@./bin/build-image --name=$(NAME) --tag=$(TAG) --nginx-prefix=$(NGINX_PREFIX)

.PHONY: rmi
rmi:
	@source ../etc/docker/common.sh && remove_image "$(NAME):$(TAG)"

.PHONY: run
run:
	@docker run -i -t --rm $(NAME):$(TAG) /bin/bash

.PHONY: purge
purge:
	@rm -rf $(NGINX_PREFIX)
	@rm -rf $(DOCKER_SOURCE)/nginx
	@rm -f $(DOCKER_SOURCE)/uwsgi

.PHONY: fresh
fresh: purge rmi image

