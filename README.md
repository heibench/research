# tool-evaluation

How we find out whether our verification tools actually help — and what they
cost.

We build tools that check engineering intent against what a design really is:
geometry, connectivity, fabrication output. Each rests on a claim that has never
been measured, which is that **giving an agent a machine-checkable contract and
an honest verdict produces better work than not giving it one.** That claim is
plausible, load-bearing, and currently unevidenced. This repository holds the
method for settling it, the prior art, and the decisions taken along the way.

It holds no harness and runs no experiments. Those live with the tool they
measure.

## Layout

| path | what it holds |
| --- | --- |
| `docs/methodology.md` | how to design an experiment that answers "does this tool help?" — arms, oracles, cost, gaming, reporting |
| `docs/bibliography.md` | one entry per source, each stating what it **established** |
| `decisions/` | numbered decision records: what we chose, on what evidence, and what would change it |
| `raw/` | verbatim captured research, dated and **unmaintained** — so the synthesis can be audited rather than trusted |

## What this repository refuses

- **Harnesses and cases.** They belong beside the tool they measure. A harness
  that tests whether a tool's console output drives a correct edit must run on
  the pull request that changes that output.
- **Rules binding every repository.** A finding here may *become* a standard —
  "every tool eval reports cost-per-solve and hack rate separately" is a repo
  convention — and standards live in `dev-toolbox`. This repo holds evidence; the
  rule it produced lives where rules live, and the record here links to it.
- **Work.** The repo holds state; the issue tracker holds work. Implementation
  issues are filed against the repository whose code changes.
- **Answer keys.** Defect taxonomies, held-out defect classes and expected
  detection maps do not go in a public repository — publishing them contaminates
  the benchmark they describe. See `docs/methodology.md` §7.

## Status

Early. The methodology and bibliography are written; the decision records and
the first experiment are not. Nothing here has been used to run a study yet, and
the one existing eval harness in the org — partspec's — predates all of it.

## The question that started this

Three harnesses already existed, and none of them answered it:

- a convergence eval — does the tool's output drive an agent to a correct fix?
  Treatment only, no control.
- an authoring eval — do the docs change what the agent writes? Control and
  treatment, but the treatment is the *documentation* and the oracle is the
  tool's own lint.
- a nine-agent adoption study — can an agent operate the tool at all? No
  control arm.

None has a no-tool arm, none uses an oracle independent of the tool, and none
records a single token. A survey of the public literature found the same gap:
the one benchmark with both a machine-checkable oracle and a clean tool-on/off
ablation reports no cost at all, and the one artifact reporting tokens against a
verification condition has confounded arms.

## Reading order

`docs/methodology.md` first — it is the reusable part. `docs/bibliography.md` is
a reference, not a narrative. `raw/` only if you want to check our work.

## Conventions

Citations carry an access date and, where possible, an arXiv ID or commit SHA,
because there is deliberately no link checker in the gate: a network-dependent
check would break the rule that CI verifies the same commands as local
development, and would fail on somebody else's outage.

## License

Apache-2.0.
