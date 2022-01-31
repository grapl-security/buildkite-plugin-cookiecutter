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

@test "pre-exit hook works" {
    run "${PWD}/hooks/pre-exit"
    assert_success
}
