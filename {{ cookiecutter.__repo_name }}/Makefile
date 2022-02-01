COMPOSE_USER=$(shell id -u):$(shell id -g)

RUN_CHECK := docker-compose run --rm --user=${COMPOSE_USER}

.DEFAULT_GOAL=all

# Formatting
########################################################################

.PHONY: format
format: format-shell format-build-files

.PHONY: format-shell
format-shell:
	./pants fmt ::

.PHONY: format-build-files
format-build-files:
	./pants update-build-files

# Linting
########################################################################

.PHONY: lint
lint: lint-shell lint-plugin lint-build-files

.PHONY: lint-shell
lint-shell:
	./pants filter --target-type=shell_sources,shunit2_tests :: | xargs ./pants lint

.PHONY: lint-plugin
lint-plugin:
	${RUN_CHECK} plugin-linter

.PHONY: lint-build-files
lint-build-files:
	./pants update-build-files --check

# Testing
########################################################################
.PHONY: test
test: test-shell test-plugin

.PHONY: test-shell
test-shell:
	./pants test ::

.PHONY: test-plugin
test-plugin:
	${RUN_CHECK} plugin-tester

########################################################################

.PHONY: all
all: format lint test
