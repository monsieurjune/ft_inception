# Project Properties
SHELL			:= /usr/bin/env sh
DOCKER_COMPOSE	:= docker compose

# ======= Secret =======
SECRET_DIR		:= ./secret/
SECRET_FILES	:= credentials.txt \
					db_password.txt \
					db_root_password.txt
SECRETS			:= $(addprefix $(SECRET_DIR), $(SECRET_FILES))

# ======= Source =======
SRC_DIR			:= ./srcs
REQ_DIR			:= $(SRC_DIR)/requirements
ENV_FILE		:= $(SRC_DIR)/.env
WRAPPER			:= $(SHELL) $(REQ_DIR)/tools/wrapper.sh $(ENV_FILE)
COMPOSE_FILE	:= $(SRC_DIR)/docker-compose.yml

# PHONY
.PHONY: gen genenv gennginx genwp up start stop down fdown reset check

# Source Tools Rule
genenv: $(ENV_FILE)

$(ENV_FILE):
	$(SHELL) $(REQ_DIR)/tools/setenv.sh

# ======= NGINX =======
NGINX_DIR		:= $(REQ_DIR)/nginx
NGINX_RULE_FILE	:= $(NGINX_DIR)/conf/rules/default.conf
NGINX_SSL_CRT	:= $(NGINX_DIR)/conf/ssl/server.crt
NGINX_SSL_KEY	:= $(NGINX_DIR)/conf/ssl/server.key

# nginx rule
gennginx: $(NGINX_RULE_FILE) $(NGINX_SSL_CRT) $(NGINX_SSL_KEY)

$(NGINX_RULE_FILE):
	@$(WRAPPER) $(NGINX_DIR)/tools/generate_nginx.sh

$(NGINX_SSL_CRT):
	@$(WRAPPER) $(NGINX_DIR)/tools/generate_ssl.sh

$(NGINX_SSL_KEY):
	@$(WRAPPER) $(NGINX_DIR)/tools/generate_ssl.sh

# ======= WORDPRESS =======
WP_DIR		:= $(REQ_DIR)/wordpress
WP_SRCS_DIR	:= $(WP_DIR)/tools/wordpress
WP_CLI_FILE	:= $(WP_DIR)/tools/wp-cli.phar

# wordpress rule
genwp: $(WP_SRCS_DIR) $(WP_CLI_FILE)

$(WP_SRCS_DIR):
	@$(WRAPPER) $(WP_DIR)/tools/download-wordpress.sh

$(WP_CLI_FILE):
	@$(WRAPPER) $(WP_DIR)/tools/download-wp-cli.sh

# Project Rules

gen: genenv gennginx genwp

up:
	@$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up --detach --build

start:
	@$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) start

stop:
	@$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) stop

restart:
	@$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) restart

down:
	@$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down

fdown:
	@$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down -v

reset: fdown up