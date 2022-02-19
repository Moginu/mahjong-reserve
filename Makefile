RUN_WITH_ENV := source venv/bin/activate &&

.DEFAULT_GOAL := help

ifeq (manage,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

help:  ## print this help
	@# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo ""
.PHONY: help

clean:  ## remove build artifacts
	rm -fr venv/
.PHONY: clean

install:  ## install this package
	$(RUN_WITH_ENV) pip install -r requirements.txt
.PHONY: install

manage: ## django's manege.py
	$(RUN_WITH_ENV) python manage.py $(RUN_ARGS)
.PHONY: manage

run: ## run this project
	$(RUN_WITH_ENV) heroku local -p 12345
.PHONY: run
