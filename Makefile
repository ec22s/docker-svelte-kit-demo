SHELL=/bin/bash

build_port=3000
test_port=5173
image_name=svlete-kit-image
container_name=svlete-kit-container
dev_service_name=svelte-kit-dev

.PHONY: $(shell egrep -oh ^[a-zA-Z0-9][a-zA-Z0-9_-]+: $(MAKEFILE_LIST) | sed 's/://')

up:
	docker build . -t ${image_name}
	docker run -d --rm --name ${container_name} ${image_name}

down:
	docker rm -fv ${container_name}
	docker rmi ${image_name}

restart:
	docker restart ${container_name}

clean-restart:
	make down && make up

test:
	docker exec ${container_name} sh -c "wget -q -S -O - http://127.0.0.1:${build_port} > /dev/null"

dev-up:
	docker compose up -d --build

dev-down:
	docker compose down -v --rmi all

dev-restart:
	docker compose restart

dev-clean-restart:
	make dev-down && make dev-up

dev-in:
	docker compose exec -it ${dev_service_name} sh

dev-test:
	docker compose exec ${dev_service_name} sh -c "wget -q -S -O - http://localhost:${test_port} > /dev/null"
