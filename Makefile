# Makefile
.DEFAULT_GOAL := help

.PHONY: install-python-tools install-node-tools install-hooks check lint format uninstall-hooks help

install-python-tools:  ## Install Python tools required for linting
	python3 -m pip install --upgrade pip
	pip install pre-commit ruff yamllint ansible-lint

install-node-tools:  ## Install Node tools required for linting
	npm install -g markdownlint-cli2

install-tools: install-python-tools install-node-tools  ## Install Python and Node tools required for linting

install-hooks: install-tools  ## Install tools and register pre-commit Git hook
	pre-commit install

validate:  ## Run all code quality checks
	pre-commit run --all-files

lint:  ## Run linting tools manually (ruff, yamllint, ansible-lint)
	ruff check .
	yamllint .
	ansible-lint .
	markdownlint-cli2 "**/*.md"

format:  ## Run Python formatting tools manually (ruff)
	ruff format .

uninstall-hooks:  ## Uninstall pre-commit hook from .git/hooks
	pre-commit uninstall

help:  ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "%-20s %s\n", $$1, $$2}'
