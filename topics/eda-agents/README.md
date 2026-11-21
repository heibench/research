# eda-agents

**Question:** what separates a circuit board an AI agent designed that is
actually good from one that only looks finished, and which of those differences
can a tool check rather than a skill file describe?

The answer shapes heibench/boardwright: which checks it grows, and what the
agent skill it will ship (boardwright#48) tells an agent to do.

| file | what it holds |
| --- | --- |
| [`brief.md`](brief.md) | the research plan: sub-questions, sources, capture rules, workstreams |
| [`findings.md`](findings.md) | the synthesis: failure modes graded and mapped to who catches them, success-claim evidence, method, prior art, implications for boardwright |
| [`problems.md`](problems.md) | the causes behind the failure modes, and the layer of an agent's toolchain where each can be addressed, set against heibench's tools |
| [`bibliography.md`](bibliography.md) | one entry per source, each stating what it **established** |

Captures behind them are the `2026-11-21-eda-agents-*` files in
[`raw/`](../../raw/).

## Status

First pass captured and synthesised 2026-11-21: workstreams A to E, R (Reddit,
by hand) and V. Proposed boardwright checks and skill rules in `findings.md`
§5 are filed as boardwright#122 to #126 and #128. `problems.md` (2026-11-21)
reads the same captures for causes and layers; its proposals are for
discussion, none filed.
