.DEFAULT_GOAL=all

.PHONY: help
help: ## Print this help
	@printf -- '\n'
	@printf -- '                                                     __ \n'
	@printf -- '             (≡)         ____ _ _____ ____ _ ____   / / \n'
	@printf -- '                \       / __ `// ___// __ `// __ \ / /  \n'
	@printf -- '                (≡)    / /_/ // /   / /_/ // /_/ // /   \n'
	@printf -- '                /      \__, //_/    \__,_// .___//_/    \n'
	@printf -- '             (≡)      /____/             /_/            \n'
	@printf -- '\n'
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make ${FMT_BLUE}<target>${FMT_END}\n"} \
		 /^[a-zA-Z0-9_-]+:.*?##/ { printf "  ${FMT_BLUE}%-46s${FMT_END} %s\n", $$1, $$2 } \
		 /^##@/ { printf "\n${FMT_BOLD}%s${FMT_END}\n", substr($$0, 5) } ' \
		 $(MAKEFILE_LIST)
	@printf '\n'

##@ Formatting
########################################################################

.PHONY: format
format: ## Reformat all code
format: format-build-files format-python format-shell

.PHONY: format-build-files
format-build-files: ## Reformat all Pants BUILD files
	./pants update-build-files

.PHONY: format-python
format-python: ## Reformat all python code
	./pants filter --target-type=python_sources,python_tests :: | xargs ./pants fmt

.PHONY: format-shell
format-shell: ## Reformat all shell code
	./pants filter --target-type=shell_sources,shunit2_tests :: | xargs ./pants fmt

##@ Linting
########################################################################

.PHONY: lint
lint: ## Lint all code
lint: lint-build-files lint-python lint-shell

.PHONY: lint-build-files
lint-build-files: ## Lint Pants BUILD files
	./pants update-build-files --check

.PHONY: lint-python
lint-python: ## Lint python code
	./pants filter --target-type=python_sources,python_tests :: | xargs ./pants lint

.PHONY: lint-shell
lint-shell: ## Lint shell code
	./pants filter --target-type=shell_sources,shunit2_tests :: | xargs ./pants lint

##@ Typecheck
########################################################################

.PHONY: typecheck
typecheck: ## Typecheck Python Code
	./pants check ::

##@ Testing
########################################################################
.PHONY: test
test: ## Run all tests
test: test-template

.PHONY: test-template
test-template: ## Test templates
	./pants test ::

########################################################################

.PHONY: all
all: format lint typecheck test
