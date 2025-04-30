# Project Properties
SHELL			:= /usr/bin/env bash
DOCKER_COMPOSE	:= docker compose

# ======= Source =======
SRC_DIR			:= ./srcs
REQ_DIR			:= $(SRC_DIR)/requirements
ENV_FILE		:= $(SRC_DIR)/.env
WRAPPER			:= $(SHELL) $(REQ_DIR)/tools/wrapper.sh $(ENV_FILE)
COMPOSE_FILE	:= $(SRC_DIR)/docker-compose.yml

# PHONY
.PHONY: secret \
		gen \
		genenv \
		gennginx \
		genwp \
		gendata \
		up \
		start \
		stop \
		restart \
		down \
		fdown \
		reset \
		delconfig

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

# ======== DATA ==========
DATA_DIR		:= $(HOME)/data
DATABASE_DIR	:= $(DATA_DIR)/database
WORDPRESS_DIR	:= $(DATA_DIR)/wordpress

# Data Rules
gendata:	$(DATABASE_DIR) $(WORDPRESS_DIR)

$(DATABASE_DIR):
	mkdir -p $(DATABASE_DIR)

$(WORDPRESS_DIR):
	mkdir -p $(WORDPRESS_DIR)

# ======= Secret =======
SECRET_DIR			:= ./secrets
CREDENT_FILE		:= $(SECRET_DIR)/credentials.txt
DB_PWD_FILE			:= $(SECRET_DIR)/db_password.txt
DB_ROOT_PWD_FILE	:= $(SECRET_DIR)/db_root_password.txt

# Secret Rules
secret:	$(CREDENT_FILE) $(DB_PWD_FILE) $(DB_ROOT_PWD_FILE)

$(CREDENT_FILE):
	@echo "WORDPRESS_TITLE=" > $(CREDENT_FILE)
	@echo "WORDPRESS_ADMIN_USER=" >> $(CREDENT_FILE)
	@echo "WORDPRESS_ADMIN_PASSWORD=" >> $(CREDENT_FILE)
	@echo "WORDPRESS_ADMIN_EMAIL=" >> $(CREDENT_FILE)

$(DB_PWD_FILE):
	touch $(DB_PWD_FILE)

$(DB_ROOT_PWD_FILE):
	touch $(DB_ROOT_PWD_FILE)

# All generate file
GEN_FILES	:= $(ENV_FILE) \
				$(NGINX_RULE_FILE) \
				$(NGINX_SSL_CRT) \
				$(NGINX_SSL_KEY) \
				$(WP_CLI_FILE) \
				$(WP_SRCS_DIR)

# Project Rules

gen: genenv gennginx genwp gendata

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

delconfig:
	rm -rf $(GEN_FILES)

reset: fdown up