.DEFAULT_GOAL=all

# Formatting
########################################################################

.PHONY: format
format: format-build-files format-python format-shell

.PHONY: format-build-files
format-build-files:
	./pants update-build-files

.PHONY: format-python
format-python:
	./pants filter --target-type=python_sources,python_tests :: | xargs ./pants fmt

.PHONY: format-shell
format-shell:
	./pants filter --target-type=shell_sources,shunit2_tests :: | xargs ./pants fmt

# Linting
########################################################################

.PHONY: lint
lint: lint-build-files lint-python lint-shell

.PHONY: lint-build-files
lint-build-files:
	./pants update-build-files --check

.PHONY: lint-python
lint-python:
	./pants filter --target-type=python_sources,python_tests :: | xargs ./pants lint

.PHONY: lint-shell
lint-shell:
	./pants filter --target-type=shell_sources,shunit2_tests :: | xargs ./pants lint

# Typecheck
########################################################################

.PHONY: typecheck
typecheck:
	./pants check ::

# Testing
########################################################################
.PHONY: test
test: test-template

.PHONY: test-template
test-template:
	./pants test ::

########################################################################

.PHONY: all
all: format lint typecheck test
