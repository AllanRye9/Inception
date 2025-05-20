COMPOSE=docker-compose
COMPOSE_FILE=srcs/docker-compose.yml

.PHONY: all build run clean fclean re cc

build:
	@echo "[+] Building services..."
	@chmod +x ./srcs/requirements/wordpress/tools/make_dir.sh
	@exec ./srcs/requirements/wordpress/tools/make_dir.sh
	@$(COMPOSE) -f $(COMPOSE_FILE) build --no-cache

all: fclean build

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
	
cc:
	@echo "Freeing memory on host ... "
	@sudo sync; echo 1 | sudo tee /proc/sys/vm/drop_caches
	@sudo sync; echo 2 | sudo tee /proc/sys/vm/drop_caches
	@sudo sync; echo 3 | sudo tee /proc/sys/vm/drop_caches
	@sudo swapoff -a
	@sudo swapon -a

re: fclean build run
