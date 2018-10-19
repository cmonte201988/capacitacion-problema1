# include ./makefiles/task.mk
include ./makefiles/deploy-ghpages.mk

.DEFAULT_GOAL := help
.PHONY : resources

APPDIR= /app
WORKDIR = /app
IMAGE = percytataje10/orbis-training-docker:2.0



install: ## Make install
	docker run -it --rm -v $$PWD:$(APPDIR) -w $(WORKDIR) $(IMAGE) npm install

start:	## Make start
	docker run -p 1042:3030 -p 35729:35729 --rm -v $$PWD:$(APPDIR) -w $(WORKDIR) $(IMAGE) npm start

release: ## build project
	docker run -p 1042:3030 -p 35729:35729 -v $$PWD:$(APPDIR) -w $(WORKDIR)  $(IMAGE) npm run release

greet: ## Ejecuta saludo
	docker run -e VAR="TATAJE" -it -v $$PWD:$(APPDIR) -w $(WORKDIR) $(IMAGE) sh resources/example.sh

resources: ## saludando por bash: make resources
	@echo 'Hola recursos!'

## Target Help ##
help:
	@printf "\033[31m%-22s %-59s %s\033[0m\n" "Target" " Help" "Usage"; \
	printf "\033[31m%-22s %-59s %s\033[0m\n"  "------" " ----" "-----"; \
	grep -hE '^\S+:.*## .*$$' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' | sort | awk 'BEGIN {FS = ":"}; {printf "\033[32m%-22s\033[0m %-58s \033[34m%s\033[0m\n", $$1, $$2, $$3}'