# research

Research for the heibench org: prior art, method and decisions that shape what
the tools become. The org spans fields — CAD, electronics, fabrication,
reference management, wikis — so the work is split by **topic**, and every
topic follows the same rules about evidence.

It holds no code, no harness and runs no experiments. Those live with the tool
they serve; this repository holds what we found out and what we decided.

## Layout

| path | what it holds |
| --- | --- |
| `topics/<topic>/` | one research question and its maintained synthesis: a `README.md` stating the question and status, plus findings and a `bibliography.md` |
| `decisions/` | numbered decision records: what we chose, on what evidence, and what would change it |
| `raw/` | verbatim captured research, dated and **unmaintained**, so the synthesis can be audited rather than trusted |

## Topics

| topic | question |
| --- | --- |
| [`agent-evaluation`](topics/agent-evaluation/) | Does giving an agent one of our verification tools produce better work, and at what cost? |
| [`eda-agents`](topics/eda-agents/) | What separates a good AI-designed circuit board from one that only looks finished, and which differences can a tool check? |

A new topic is a directory with a `README.md` that states its question in a
form a result could answer, and a status line kept true. Start one when a
question outlives a single session; until then, the capture in `raw/` is enough.

## What this repository refuses

- **Harnesses and cases.** They belong beside the tool they measure. A harness
  that tests whether a tool's console output drives a correct edit must run on
  the pull request that changes that output.
- **Rules binding every repository.** A finding here may *become* a standard,
  and standards live in `dev-toolbox`. This repo holds evidence; the rule it
  produced lives where rules live, and the record here links to it.
- **Work.** The repo holds state; the issue tracker holds work. Implementation
  issues are filed against the repository whose code changes.
- **Answer keys.** Defect taxonomies, held-out defect classes and expected
  detection maps do not go in a public repository; publishing them contaminates
  the benchmark they describe. See
  [`topics/agent-evaluation/methodology.md`](topics/agent-evaluation/methodology.md)
  §7 and heibench/research#2.

## Reading order

A topic's `README.md` first, then its findings. Each `bibliography.md` is a
reference, not a narrative. `raw/` only if you want to check our work.

## Conventions

Citations carry an access date and, where possible, an arXiv ID or commit SHA,
because there is deliberately no link checker in the gate: a network-dependent
check would break the rule that CI verifies the same commands as local
development, and would fail on somebody else's outage.

Renamed from `tool-evaluation` on 2026-11-21, when its scope widened from one
question to the org's research. GitHub redirects the old URL.

## License

Apache-2.0.
