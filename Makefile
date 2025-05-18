COMPOSE=docker-compose
COMPOSE_FILE=srcs/docker-compose.yaml

.PHONY: all build run clean fclean re root bonus

all: fclean build

# path to be changed later.
build:
	@echo "[+] Building services..."
	@mkdir -p /home/wordpress 
	@mkdir -p /home/mysql
	@$(COMPOSE) -f $(COMPOSE_FILE) build --no-cache

run:
	@$(COMPOSE) -f $(COMPOSE_FILE) up -d

clean:
	@echo "[+] Stopping and removing containers..."
	@$(COMPOSE) -f $(COMPOSE_FILE) down --volumes --remove-orphans 
	@if docker images | grep -w "nginx" > /dev/null; then \
		docker stop nginx 2>/dev/null || true; \
		docker rmi -f nginx 2>/dev/null || true; \
	fi

	@if docker images | grep -w "mariadb" > /dev/null; then \
		docker stop mariadb 2>/dev/null || true; \
		docker rm -f mariadb 2> /dev/null || true ; \
		docker rmi -f mariadb 2>/dev/null || true; \
	fi

fclean: clean
	@echo "[+] Pruning system..."
	@docker image prune -f --force
	@docker container prune -f --force
	@docker system prune -af --volumes

re: fclean build run
