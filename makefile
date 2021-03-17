# Deploy lyx.local

.PHONY: all
all:
	@echo To deploy run:  make deploy

.PHONY: deploy
deploy:
	@bash etc/deploy.sh
