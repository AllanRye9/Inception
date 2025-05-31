COMPOSE=docker-compose
COMPOSE_FILE=srcs/docker-compose.yml
MK_DIR_PATH=srcs/requirements/wordpress/tools/make-dir.sh

.PHONY: all build run clean fclean re

build:
	@echo "[+] Building services..."
	@sh $(MK_DIR_PATH)
	@$(COMPOSE) -f $(COMPOSE_FILE) build --no-cache

all: fclean build

run:
	@$(COMPOSE) -f $(COMPOSE_FILE) up -d

clean:
	@echo "[+] Stopping and removing containers..."
	@$(COMPOSE) -f $(COMPOSE_FILE) down

fclean: clean
	@docker stop $$(docker ps -qa) || echo "No containers to stop"
	@docker rm $$(docker ps -qa) || echo "No containers to remove"
	@docker rmi -f $$(docker images -qa) || echo "No images to remove"
	@docker volume rm $$(docker volume ls -q) || echo "No volumes to remove"
	@docker network rm $$(docker network ls -q) || echo "No networks to remove"
	@sudo rm -rf /home/oallan/data/
	@docker system prune --all --force

re: fclean build run
