.DEFAULT_GOAL := help
.PHONY : resources

APPDIR= /app
WORKDIR = /app
IMAGE = percytataje10/orbis-training-docker:2.0


build: ## build
	docker-compose -f docker-compose.build.yml build

push: ## push
	docker push percytataje10/$(IMAGE)

up: ## up
	docker-compose up

login: ## login
	docker login


help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'