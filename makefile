# Makefile to deploy lyx.local

.PHONY: all
all:
	@echo To deploy run:  make deploy

# Initialize
.PHONY: init
init:
	@echo Initializing....
	@bash etc/init.sh

# Copy to UserDir.
.PHONY: init
deploy:
	@echo Deploying....
	@bash etc/deploy.sh

# Reflect changes in UserDir.
.PHONY: reconfigure
reconfigure:
	@bash etc/reconfigure.sh

# Upgrade layout format.
.PHONY: upgrade
upgrade:
	@bash etc/upgrade.sh

# Deploy custom LaTeX style files.
.PHONY: texmf
texmf:
	@bash etc/texmf.sh


# Compile demo files.
FORMAT := pdf5
-include etc/config

demo_lyx := $(wildcard demo/*.lyx)
demo_pdf := $(demo_lyx:.lyx=.pdf)

demo: $(demo_pdf);
$(demo_pdf): %.pdf: %.lyx
	$(LyX) --export-to $(FORMAT) $@ $<


# Clean up
.PHONY: clean
clean:
	rm -f demo/*.lyx~
	rm -f LyX/templates/*.lyx~
	find . -name '.DS_Store' -type f -delete
