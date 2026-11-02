#!/usr/bin/env bash

set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
cd "$HERE/.."

unit=$(sed -n 's/^unit = "\(.*\)"$/\1/p' bridge.toml)
[ -f js/Cargo.toml ] || { echo "wasm.sh: no js/Cargo.toml; run scripts/bridge.sh" >&2; exit 1; }
target=$(cargo metadata --format-version 1 --no-deps | sed -n 's/.*"target_directory":"\([^"]*\)".*/\1/p')
built="$target/wasm32-unknown-unknown/wasm"
locked=$(grep -A1 '^name = "wasm-bindgen"$' Cargo.lock | sed -n 's/^version = "\(.*\)"$/\1/p')
install="cargo install wasm-bindgen-cli --version $locked --locked"
command -v wasm-bindgen > /dev/null || { echo "wasm.sh: wasm-bindgen is not installed; $install" >&2; exit 1; }
cli=$(wasm-bindgen --version | awk '{print $2}')
[ "$cli" = "$locked" ] || { echo "wasm.sh: wasm-bindgen $cli is installed but Cargo.lock wants $locked; $install" >&2; exit 1; }

cargo build --profile wasm --target wasm32-unknown-unknown --lib -p "mrly-$unit-js"

rm -rf js/pkg
wasm-bindgen "$built/mrly_${unit}_js.wasm" --target web --out-dir js/pkg

printf '%s %s bytes\n' "$unit" "$(wc -c < "js/pkg/mrly_${unit}_js_bg.wasm" | tr -d ' ')"
