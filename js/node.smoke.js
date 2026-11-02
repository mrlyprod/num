import assert from "node:assert/strict";
import { Rng } from "@mrlyprod/num";

const draws = (rng) => [rng.unit(), rng.below(1000), rng.range(5, 9)];
const first = draws(new Rng(7));
assert.deepEqual(draws(new Rng(7)), first);
assert.ok(first[0] >= 0 && first[0] < 1);
console.log("num node smoke ok");
