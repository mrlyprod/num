#!/usr/bin/env bash

set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
cd "$HERE/.."

cargo run -q --manifest-path "$HERE/../../bridge/Cargo.toml" -- "$@"
