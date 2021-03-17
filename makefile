# Deploy lyx.local
include etc/config

.PHONY: all
all:
	@echo To deploy run:  make deploy

.PHONY: deploy
deploy:
	@bash etc/deploy.sh

.PHONY: reconfigure
reconfigure:
	@bash etc/reconfigure.sh
