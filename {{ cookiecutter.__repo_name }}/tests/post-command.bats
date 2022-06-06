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

@test "post-command hook works" {
    run "${PWD}/hooks/post-command"
    assert_success
}
