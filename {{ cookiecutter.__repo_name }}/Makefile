DOCKER_COMPOSE_CHECK := docker compose run --rm
PANTS_SHELL_FILTER := ./pants filter --target-type=shell_sources,shunit2_tests :: | xargs ./pants

.DEFAULT_GOAL=all

.PHONY: all
all: format
all: lint
all: test
all: ## Run all operations

.PHONY: help
help: ## Print this help
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make <target>\n"} \
		 /^[a-zA-Z0-9_-]+:.*?##/ { printf "  %-46s %s\n", $$1, $$2 } \
		 /^##@/ { printf "\n%s\n", substr($$0, 5) } ' \
		 $(MAKEFILE_LIST)
	@printf '\n'

##@ Formatting
########################################################################

.PHONY: format
format: format-build-files
format: format-shell
format: ## Automatically format all code

.PHONY: format-build-files
format-build-files: ## Format Pants BUILD files
	./pants update-build-files

.PHONY: format-shell
format-shell: ## Format shell scripts
	$(PANTS_SHELL_FILTER) fmt

##@ Linting
########################################################################

.PHONY: lint
lint: lint-build-files
lint: lint-docker
lint: lint-plugin
lint: lint-shell
lint: ## Perform lint checks on all files

.PHONY: lint-build-files
lint-build-files: ## Lint Pants BUILD files
	./pants update-build-files --check

.PHONY: lint-docker
lint-docker:  ## Lint Dockerfiles
	./pants filter --target-type=docker_image :: | xargs ./pants lint

.PHONY: lint-plugin
lint-plugin: ## Lint the Buildkite plugin metadata
	$(DOCKER_COMPOSE_CHECK) plugin-linter

.PHONY: lint-shell
lint-shell: ## Lint the shell scripts
	$(PANTS_SHELL_FILTER) lint

##@ Testing
########################################################################

.PHONY: test
test: test-shell
test: test-plugin
test: ## Run all tests

.PHONY: test-plugin
test-plugin: ## Test the Buildkite plugin locally (does *not* run a Buildkite pipeline)
	$(DOCKER_COMPOSE_CHECK) plugin-tester

.PHONY: test-shell
test-shell: ## Test shell scripts and libraries
	$(PANTS_SHELL_FILTER) test
