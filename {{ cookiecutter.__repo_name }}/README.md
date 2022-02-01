# {{ cookiecutter.friendly_name }} Buildkite Plugin

{{ cookiecutter.description }}

## Example
```yml
steps:
    - label: Blah
      plugins:
        - {{ cookiecutter.github_org }}/{{ cookiecutter.__plugin_name }}#v0.1.0
```
