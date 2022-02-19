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
	source venv/bin/activate && pip install -r requirements.txt
.PHONY: install

manage: ## django's manege.py
	source venv/bin/activate && python manage.py $(RUN_ARGS)
.PHONY: manage
