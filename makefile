# Makefile to deploy lyx.local

.PHONY: all
all:
	@echo To deploy run:  make deploy

# Initialize
init: etc/config

etc/config:
	@echo Initializing....
	@bash etc/init.sh

# Copy to UserDir.
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

# Compile demo files.
demo_lyx := $(wildcard demo/*.lyx)
demo_pdf := $(demo_lyx:.lyx=.pdf)

demo: $(demo_pdf);
$(demo_pdf): %.pdf: %.lyx
	$(LyX) --export-to pdf5 $@ $<


# Clean up
.PHONY: clean
clean:
	rm -f demo/*.lyx~
	rm -f LyX/templates/*.lyx~
	find . -name '.DS_Store' -type f -delete
