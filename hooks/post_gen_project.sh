#!/usr/bin/env bash

# Ignore apparent constant test expressions; this file is templated,
# so those "constants" will be replaced by other values.
#
# https://www.shellcheck.net/wiki/SC2050
# shellcheck disable=SC2050

set -euo pipefail

echo "Fetching latest 'pants' script"
curl -L -o ./pants https://pantsbuild.github.io/setup/pants
chmod a+x pants

# Remove unused hook files and test files (because otherwise this is
# rather awkward in current Cookiecutter).
remove_files() {
    local -r hook_name="${1}"

    echo "Removing hooks/${hook_name}"
    rm -f "hooks/${hook_name}"
    echo "Removing tests/${hook_name}.bats"
    rm -f "tests/${hook_name}.bats"
}

[ "{{ cookiecutter.use_environment_hook }}" != "True" ] && remove_files environment
[ "{{ cookiecutter.use_pre_checkout_hook }}" != "True" ] && remove_files pre-checkout
[ "{{ cookiecutter.use_checkout_hook }}" != "True" ] && remove_files checkout
[ "{{ cookiecutter.use_post_checkout_hook }}" != "True" ] && remove_files post-checkout
[ "{{ cookiecutter.use_pre_command_hook }}" != "True" ] && remove_files pre-command
[ "{{ cookiecutter.use_command_hook }}" != "True" ] && remove_files command
[ "{{ cookiecutter.use_post_command_hook }}" != "True" ] && remove_files post-command
[ "{{ cookiecutter.use_pre_artifact_hook }}" != "True" ] && remove_files pre-artifact
[ "{{ cookiecutter.use_post_artifact_hook }}" != "True" ] && remove_files post-artifact
[ "{{ cookiecutter.use_pre_exit_hook }}" != "True" ] && remove_files pre-exit

# This is a hacky way to fail if no files (other than BUILD) exist in
# the hooks directory.
if ! find hooks -type f -not -name BUILD | grep .; then
    echo "Must specify at least one hook!"
    exit 1
fi

# Ensure that hooks/BUILD (and anything else, really) is properly
# formatted (because the templating may leave it in a weird state).
./pants update-build-files

echo "Initializing Git repository"
git init
git remote add origin \
    "https://github.com/{{ cookiecutter.github_org }}/{{ cookiecutter.__repo_name }}"
git add .
git commit \
    --message "Initial plugin generation"
git branch --move main

# Ideally, we'd add this, but the upstream repository may not actually
# exist yet
# git branch --set-upstream-to=origin/main
