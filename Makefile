# Run a Pants goal across all Python files
PANTS_PYTHON_FILTER := ./pants --filter-target-type=python_source,python_test
# Run a Pants goal across all shell files
PANTS_SHELL_FILTER := ./pants --filter-target-type=shell_source,shunit2_test

.DEFAULT_GOAL=all

.PHONY: all
all: format
all: lint
all: typecheck
all: test
all: ## Run (almost!) all commands

.PHONY: help
help: ## Print this help
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make ${FMT_BLUE}<target>${FMT_END}\n"} \
		 /^[a-zA-Z0-9_-]+:.*?##/ { printf "  ${FMT_BLUE}%-46s${FMT_END} %s\n", $$1, $$2 } \
		 /^##@/ { printf "\n${FMT_BOLD}%s${FMT_END}\n", substr($$0, 5) } ' \
		 $(MAKEFILE_LIST)
	@printf '\n'

##@ Formatting
########################################################################

.PHONY: format
format: format-build-files
format: format-python
format: format-shell
format: ## Reformat all code

.PHONY: format-build-files
format-build-files: ## Reformat all Pants BUILD files
	./pants update-build-files ::

.PHONY: format-python
format-python: ## Reformat all python code
	$(PANTS_PYTHON_FILTER) fmt ::

.PHONY: format-shell
format-shell: ## Reformat all shell code
	$(PANTS_SHELL_FILTER) fmt ::

##@ Linting
########################################################################

.PHONY: lint
lint: lint-build-files
lint: lint-python
lint: lint-shell
lint: ## Lint all code

.PHONY: lint-build-files
lint-build-files: ## Lint Pants BUILD files
	./pants update-build-files --check ::

.PHONY: lint-python
lint-python: ## Lint python code
	$(PANTS_PYTHON_FILTER) lint ::

.PHONY: lint-shell
lint-shell: ## Lint shell code
	$(PANTS_SHELL_FILTER) lint ::

##@ Typecheck
########################################################################

.PHONY: typecheck
typecheck: ## Typecheck Python Code
	./pants check ::

##@ Testing
########################################################################
.PHONY: test
test: test-template
test: ## Run all tests

.PHONY: test-template
test-template: ## Test templates
	./pants test ::

##@ Utility
########################################################################

.PHONY: lockfiles
lockfiles: ## Update all lockfiles
	./pants generate-lockfiles
