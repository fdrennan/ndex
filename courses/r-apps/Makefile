SHELL=/usr/bin/zsh
.DEFAULT_GOAL := help

.PHONY: help
help:
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		 }' $(MAKEFILE_LIST)
include .env
export $(shell sed 's/=.*//' .env)

list: ## List directory
	ls

alist: ## List directory
	ls

