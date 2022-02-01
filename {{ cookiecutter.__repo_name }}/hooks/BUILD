shell_sources(
    sources = [
        {% if cookiecutter.use_environment_hook == "True" %}"environment",{% endif %}
        {% if cookiecutter.use_pre_checkout_hook == "True" %}"pre-checkout",{% endif %}
        {% if cookiecutter.use_checkout_hook == "True" %}"checkout",{% endif %}
        {% if cookiecutter.use_post_checkout_hook == "True" %}"post-checkout",{% endif %}
        {% if cookiecutter.use_pre_command_hook == "True" %}"pre-command",{% endif %}
        {% if cookiecutter.use_command_hook == "True" %}"command",{% endif %}
        {% if cookiecutter.use_post_command_hook == "True" %}"post-command",{% endif %}
        {% if cookiecutter.use_pre_artifact_hook == "True" %}"pre-artifact",{% endif %}
        {% if cookiecutter.use_post_artifact_hook == "True" %}"post-artifact",{% endif %}
        {% if cookiecutter.use_pre_exit_hook == "True" %}"pre-exit",{% endif %}
    ]
)
