COMPOSE=docker-compose
COMPOSE_FILE=srcs/docker-compose.yml

.PHONY: all build run clean fclean re root

root:
	@echo "You are now have the permission as a sudo User."
	@sudo su

all: fclean build

build:
	@echo "[+] Building services..."
	@$(COMPOSE) -f $(COMPOSE_FILE) build

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
