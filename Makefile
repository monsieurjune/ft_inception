# Project Properties
DOCKER_COMPOSE	:= docker compose

# ======= Secret =======
SECRET_DIR		:= ./secret/
CREDENT_FILE	:= $(SECRET_DIR)/credentials.txt
SECRET_FILES	:= credentials.txt \
					db_password.txt \
					db_root_password.txt
SECRETS			:= $(addprefix $(SECRET_DIR), $(SECRET_FILES))

# ======= Source =======
SRC_DIR			:= ./srcs
REQ_DIR			:= $(SRC_DIR)/requirements
ENV_FILE		:= $(SRC_DIR)/.env
COMPOSE_FILE	:= $(SRC_DIR)/docker-compose.yml

# ======= MARIA DB =======
MARIA_DIR			:= $(REQ_DIR)/mariadb

# Project Tools Rules

# Project Rules

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