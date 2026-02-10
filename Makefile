SHELL := /usr/bin/env bash

.PHONY: help hygiene review init-project hygiene-template hygiene-project review-template review-project

help:
	@echo "Common commands:"
	@echo "  make init-project           # interactive bootstrap for downstream repos"
	@echo "  make hygiene [MODE=...]     # run hygiene checks (template|project)"
	@echo "  make review [MODE=...]      # run weekly review (template|project)"
	@echo "  make hygiene-template"
	@echo "  make hygiene-project"
	@echo "  make review-template"
	@echo "  make review-project"

hygiene:
	bash scripts/agent-hygiene-check.sh $(if $(MODE),--mode $(MODE),)

review:
	bash scripts/agent-weekly-review.sh $(if $(MODE),--mode $(MODE),)

init-project:
	bash scripts/tmpl-init.sh

hygiene-template:
	$(MAKE) hygiene MODE=template

hygiene-project:
	$(MAKE) hygiene MODE=project

review-template:
	$(MAKE) review MODE=template

review-project:
	$(MAKE) review MODE=project
