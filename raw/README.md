# raw/ — unedited captured research

Verbatim output from the research pass of 2026-10-18. **Not maintained.**

These files exist so the synthesis in `docs/` can be audited rather than
trusted. Every number and URL that appears in `docs/bibliography.md` and
`docs/methodology.md` came from one of them, and where the synthesis departs
from a report — by disagreeing, narrowing, or dropping a claim — that is a
deliberate editorial act and the raw text is here to make it visible.

## Rules for this directory

- **Nothing here is edited after capture.** Not for typos, not for formatting,
  not for a link that has since moved. The whitespace hooks skip `raw/` for
  exactly this reason. If something is wrong, it is corrected in `docs/`, which
  is the maintained layer, and the correction says what it is correcting.
- **Nothing here is authoritative.** These are research notes produced in one
  pass on one day. Where a report and a doc disagree, the doc wins, because the
  doc was reviewed and these were not.
- **Links rot and are not checked.** Citations carry an access date of
  2026-10-18. There is no link checker in the gate, on purpose: a
  network-dependent check breaks the rule that CI verifies the same commands as
  local development, and would redden the gate on somebody else's outage.
- **Superseded, never deleted.** When a later pass replaces one of these, the
  new file sits beside it with its own date. A deleted report makes the
  synthesis unauditable again.

## Contents

| file | question it was asked |
| --- | --- |
| `2026-10-18-cad-agent-benchmark-prior-art.md` | What benchmarks already evaluate LLM agents on CAD, and does any answer "does a verification tool help?" |
| `2026-10-18-tool-assistance-experiment-design.md` | How do you design a defensible small-n experiment for "does tool X help an agent, and at what token cost?" |
| `2026-10-18-eval-repo-structure.md` | How do mature projects structure eval harnesses, cases and results, and is a separate repo warranted? |
| `2026-10-18-partspec-harness-map.md` | How does the existing partspec eval harness actually work, and what would extending it require? |

The last one is about one tool rather than about method. It is kept here
because it is the evidence behind several decisions, but the durable home for
harness documentation is the tool's own repository, not this one.
