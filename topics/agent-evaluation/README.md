# agent-evaluation

**Question:** does giving an agent one of our verification tools produce better
work than not giving it one, and at what cost?

We build tools that check engineering intent against what a design really is:
geometry, connectivity, fabrication output. Each rests on a claim that has never
been measured, which is that **giving an agent a machine-checkable contract and
an honest verdict produces better work than not giving it one.** That claim is
plausible, load-bearing, and currently unevidenced. This topic holds the method
for settling it and the prior art.

| file | what it holds |
| --- | --- |
| [`methodology.md`](methodology.md) | how to design an experiment that answers "does this tool help?": arms, oracles, cost, gaming, reporting |
| [`bibliography.md`](bibliography.md) | one entry per source, each stating what it **established** |

Captures behind both are the `2026-10-18-*` files in [`raw/`](../../raw/).

## Status

Early. The methodology and bibliography are written; the decision records and
the first experiment are not. Nothing here has been used to run a study yet, and
the one existing eval harness in the org, partspec's, predates all of it.

## The question that started this

Three harnesses already existed, and none of them answered it:

- a convergence eval: does the tool's output drive an agent to a correct fix?
  Treatment only, no control.
- an authoring eval: do the docs change what the agent writes? Control and
  treatment, but the treatment is the *documentation* and the oracle is the
  tool's own lint.
- a nine-agent adoption study: can an agent operate the tool at all? No
  control arm.

None has a no-tool arm, none uses an oracle independent of the tool, and none
records a single token. A survey of the public literature found the same gap:
the one benchmark with both a machine-checkable oracle and a clean tool-on/off
ablation reports no cost at all, and the one artifact reporting tokens against a
verification condition has confounded arms.

## Reading order

`methodology.md` first; it is the reusable part. `bibliography.md` is a
reference, not a narrative.
