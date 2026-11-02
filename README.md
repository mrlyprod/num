mrly-num; a MrlyMath crate: the integers, primes, divisors, series, sieves, lattices and spectra

# NUM

- Its bindings sit beside it, written by `mrly-bridge` from `bridge.toml` and `src/`: `js/` (`@mrlyprod/num`), `py/` (`mrly.num`) and `cli/` (`mrly-num`); `manifest.json` lists every crossing and `.gitattributes` every generated file.
- Builds on `mrly-core`, by version; `scripts/bridge.sh` rewrites the bindings.
- `scripts/check.sh` is the one gate: fmt, clippy, test, doc, bridge check, ruff, wasm, the leaves' tests, leak.
- A fresh clone runs `scripts/wasm.sh` once before any host builds: it writes `js/pkg/`, which is not committed.
- Until the crates are published, clone the fleet beside this repo: `scripts/bridge.sh` runs the sibling `../bridge`, and a `.cargo/config.toml` with `[patch.crates-io]` rows points every `mrly-*` dependency at its sibling folder.
- Docs: [docs.rs/mrly-num](https://docs.rs/mrly-num).

```rust
assert!(mrly_num::prime::is_prime(97));
assert_eq!(mrly_num::factor::divisors(12), vec![1, 2, 3, 4, 6, 12]);
```
