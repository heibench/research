# raw/ — unedited captured research

Verbatim output from research passes, one file per capture. **Not
maintained.** This index is the one file here that is.

These files exist so the synthesis in `topics/` can be audited rather than
trusted. Every number and URL in a topic's bibliography and findings came from
one of them, and where the synthesis departs from a report — by disagreeing,
narrowing, or dropping a claim — that is a deliberate editorial act and the raw
text is here to make it visible.

## Rules for this directory

- **Nothing here is edited after capture.** Not for typos, not for formatting,
  not for a link that has since moved. The whitespace hooks skip `raw/` for
  exactly this reason. If something is wrong, it is corrected in the topic,
  which is the maintained layer, and the correction says what it is correcting.
- **Nothing here is authoritative.** These are research notes produced in one
  pass on one day. Where a report and a doc disagree, the doc wins, because the
  doc was reviewed and these were not.
- **Links rot and are not checked.** Citations carry the access date of
  their capture. There is no link checker in the gate, on purpose: a
  network-dependent check breaks the rule that CI verifies the same commands as
  local development, and would redden the gate on somebody else's outage.
- **Superseded, never deleted.** When a later pass replaces one of these, the
  new file sits beside it with its own date. A deleted report makes the
  synthesis unauditable again.

## Contents

| file | topic | question it was asked |
| --- | --- | --- |
| `2026-10-18-cad-agent-benchmark-prior-art.md` | agent-evaluation | What benchmarks already evaluate LLM agents on CAD, and does any answer "does a verification tool help?" |
| `2026-10-18-tool-assistance-experiment-design.md` | agent-evaluation | How do you design a defensible small-n experiment for "does tool X help an agent, and at what token cost?" |
| `2026-10-18-eval-repo-structure.md` | agent-evaluation | How do mature projects structure eval harnesses, cases and results, and is a separate repo warranted? |
| `2026-10-18-partspec-harness-map.md` | agent-evaluation | How does the existing partspec eval harness actually work, and what would extending it require? |
| `2026-11-21-eda-agents-critique-harvest.md` | eda-agents | What do reviewers on HN, EEVblog, the KiCad forum and Hackaday say is wrong with AI-designed boards? (A) |
| `2026-11-21-eda-agents-success-claims.md` | eda-agents | When a post says an AI-designed board works, what evidence comes with it? (B) |
| `2026-11-21-eda-agents-skills-and-mcp.md` | eda-agents | What do KiCad agent skills and MCP servers encode, and what do they actually check? (C) |
| `2026-11-21-eda-agents-commercial-and-papers.md` | eda-agents | What do commercial tools and papers establish, and does grounding or code-first design change outcomes? (D) |
| `2026-11-21-eda-agents-grading.md` | eda-agents | Which common PCB criticisms are real, conditional or folklore, by authoritative sources? (E) |
| `2026-11-21-eda-agents-reddit.md` | eda-agents | What do recent Reddit threads, saved by hand, add to A and B? (R) |
| `2026-11-21-eda-agents-verification.md` | eda-agents | How many of A to E's claims survive a re-check against the primary source? (V) |

The last one is about one tool rather than about method. It is kept here
because it is the evidence behind several decisions, but the durable home for
harness documentation is the tool's own repository, not this one.
