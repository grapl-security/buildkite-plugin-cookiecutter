# {{ cookiecutter.friendly_name }} Buildkite Plugin

{{ cookiecutter.description }}

External contributions are always welcome; see [Building and
Contributing](#building-and-contributing) below.

## Examples
```yml
steps:
    - label: Blah
      plugins:
        - {{ cookiecutter.github_org }}/{{ cookiecutter.__plugin_name }}#v0.1.0
```

## Configuration

TODO

## Building and Contributing

Requires `make`, `docker`, and Docker Compose v2.

`make all` will run all formatting, linting, and testing.

Run `make help` to see all available targets, with brief descriptions.

Alternatively, you may also use [Gitpod](https://gitpod.io).

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/{{ cookiecutter.github_org }}/{{ cookiecutter.__repo_name }})

### Useful Background Information for Contributors

- [Buildkite Plugin Docs](https://buildkite.com/docs/plugins):
  Provides a general overview of what Buildkite plugins are and how
  they are used.
- [Writing Buildkite Plugins](https://buildkite.com/docs/plugins/writing):
  Provides more in-depth information on how to actually create a plugin.
- [Buildkite Plugin Linter](https://github.com/buildkite-plugins/buildkite-plugin-linter):
  Repository for the tool used to ensure Buildkite plugins conform to various conventions.
- [Buildkite Plugin Tester](https://github.com/buildkite-plugins/buildkite-plugin-tester):
  The testing framework used to exercise the plugin. See the [tests](./tests) directory.
- [Pants](https://pantsbuild.org):
  The build system we use in this repository. See [pants.toml](./pants.toml) for configuration.
