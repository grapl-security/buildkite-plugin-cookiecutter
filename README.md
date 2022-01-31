# Buildkite Plugin Cookiecutter
A Cookiecutter template for creating new Buildkite Plugins

## Install Cookiecutter

Use [pipx](https://pypa.github.io/pipx/installation/) to install Cookiecutter. We will also be using an
unreleased version of Cookiecutter, in order to take advantage of new
features like [the UUID extension](https://cookiecutter.readthedocs.io/en/latest/advanced/template_extensions.html#uuid4-extension) and [private template variables](https://cookiecutter.readthedocs.io/en/latest/advanced/private_variables.html)

```shell
pipx install git+https://github.com/cookiecutter/cookiecutter.git@3ece249
```

## Run Cookiecutter

```shell
cookiecutter buildkite-plugin-cookiecutter
```
