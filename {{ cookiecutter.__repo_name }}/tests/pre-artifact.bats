#!/usr/bin/env bats

load "$BATS_PLUGIN_PATH/load.bash"

# Uncomment to enable stub debugging
# export DOCKER_STUB_DEBUG=/dev/tty

setup() {
    true
}

teardown() {
    true
}

@test "pre-artifact hook works" {
    run "${PWD}/hooks/pre-artifact"
    assert_success
}
