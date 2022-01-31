#!/usr/bin/env bats

load "$BATS_PATH/load.bash"

# Uncomment to enable stub debugging
# export DOCKER_STUB_DEBUG=/dev/tty

setup() {
    true
}

teardown() {
    true
}

@test "post-artifact hook works" {
    run "${PWD}/hooks/post-artifact"
    assert_success
}
