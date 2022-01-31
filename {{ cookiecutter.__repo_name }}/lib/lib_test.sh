#!/usr/bin/env bash

oneTimeSetUp() {
    # shellcheck source-path=SCRIPTDIR
    source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
}

test_it_works() {
    output="$(do_it)"
    assertEquals "Hello World" "${output}"
}
