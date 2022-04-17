import subprocess
import uuid
from os import path
from typing import Any, Mapping

import toml


def test_bake_project(cookies) -> None:  # type: ignore[no-untyped-def]
    """
    Ensures that a basic "happy-path" generation works as expected.
    """
    result = cookies.bake(extra_context={"friendly_name": "Test Thing"})

    assert result.exit_code == 0
    assert result.exception is None

    assert result.project_path.name == "test-thing-buildkite-plugin"
    assert result.project_path.is_dir()

    hooks_dir = path.join(result.project_path, "hooks")
    assert path.exists(hooks_dir)
    assert path.isdir(hooks_dir)

    hooks_build = path.join(hooks_dir, "BUILD")
    assert path.exists(hooks_build)
    assert path.isfile(hooks_build)

    with open(hooks_build, "r") as build:
        contents = build.read()
        expected = """shell_sources(
    sources=[
        "environment",
        "pre-checkout",
        "checkout",
        "post-checkout",
        "pre-command",
        "command",
        "post-command",
        "pre-artifact",
        "post-artifact",
        "pre-exit",
    ]
)
"""
        assert contents == expected

    tests_dir = path.join(result.project_path, "tests")
    assert path.exists(tests_dir)
    assert path.isdir(tests_dir)

    for hook in [
        "environment",
        "pre-checkout",
        "post-checkout",
        "pre-command",
        "command",
        "post-command",
        "pre-artifact",
        "post-artifact",
        "pre-exit",
    ]:
        test_file = path.join(tests_dir, f"{hook}.bats")
        assert path.exists(test_file)
        assert path.isfile(test_file)

    # Contents of the pants.toml file should be as we expect
    pants_toml = toml_contents(path.join(result.project_path, "pants.toml"))
    assert pants_toml["GLOBAL"]["pants_version"] == "2.10.0"
    assert pants_toml["GLOBAL"]["plugins"] == ["toolchain.pants.plugin==0.17.0"]
    assert pants_toml["toolchain-setup"]["org"] == "grapl-security"
    assert pants_toml["toolchain-setup"]["repo"] == "test-thing-buildkite-plugin"

    repo_id = pants_toml["anonymous-telemetry"]["repo_id"]
    assert uuid.UUID(repo_id), "Generated repository ID was not a valid UUID"

    # We should be able to run `make` on the generated project and
    # have it pass.
    subprocess.run("make", cwd=result.project_path, shell=True, check=True)


def test_must_have_at_least_one_hook(cookies) -> None:  # type: ignore[no-untyped-def]
    """
    If the cookiecutter is configured to remove *all* hooks, then we
    should fail. A Buildkite plugin with no hooks makes no sense.

    """
    result = cookies.bake(
        extra_context={
            "friendly_name": "Bogus Hooks",
            "use_environment_hook": False,
            "use_pre_checkout_hook": False,
            "use_checkout_hook": False,
            "use_post_checkout_hook": False,
            "use_pre_command_hook": False,
            "use_command_hook": False,
            "use_post_command_hook": False,
            "use_pre_artifact_hook": False,
            "use_post_artifact_hook": False,
            "use_pre_exit_hook": False,
        }
    )

    assert result.exit_code == -1


def toml_contents(toml_file_path: str) -> Mapping[str, Any]:
    """Retrieve the contents of a TOML file as a dictionary."""
    with open(toml_file_path, "r") as file:
        content = file.read()
        return toml.loads(content)
