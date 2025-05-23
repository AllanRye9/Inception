COMPOSE=docker-compose
COMPOSE_FILE=srcs/docker-compose.yml

.PHONY: all build run clean fclean re

build:
	@echo "[+] Building services..."
	@$(COMPOSE) -f $(COMPOSE_FILE) build --no-cache

all: fclean build

run:
	@$(COMPOSE) -f $(COMPOSE_FILE) up -d

clean:
	@echo "[+] Stopping and removing containers..."
	@$(COMPOSE) -f $(COMPOSE_FILE) down --volumes --remove-orphans 

fclean: clean
	@echo "[+] Pruning system..."
	@docker image prune -f --force
	@docker container prune -f --force
	@docker system prune -af --volumes
	
re: fclean build run
