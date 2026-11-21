# Problems: what goes wrong, and at what layer to fix it

Written 2026-11-21 from the same captures as [`findings.md`](findings.md),
whose corrected values it uses. `findings.md` maps each symptom to the check
that would catch it. This file goes one level up: the eight causes the 44
failure modes come from, and the layer of an agent's toolchain where each cause
can be addressed. Row references follow `findings.md`: "A17" is a row of the
critique harvest, "T13" a Reddit thread, "N1" a mode only Reddit raised.

It is a reading of thin evidence. No board in any capture was measured (no
scope trace, current, thermal or EMC result), the Reddit set was hand-picked,
vendor claims are unverified, and most papers grade schematic or routing
correctness only (`findings.md`, Headline 1 and Gaps). That is enough to rank
where to work, not to call any layer solved.

## The eight causes

### 1. The agent works from wrong facts about parts

- **Symptoms.** Hallucinated package variants (A5). Obsolete and
  out-of-stock parts (A6). Wrong part facts asserted against the datasheet,
  and values invented with the datasheet supplied (A8). Invented pin numbers
  (A12) and wrong packages (A15). Datasheet constraints not applied (A7).
  Datasheets lost in PDF extraction, behind an NDA, or contradicted by errata
  (A40). One recent case: T17's first boards stayed dead until the agent
  rewrote a bootloader the chip's manual described wrongly.
- **Cause.** Part knowledge comes from the model's memory or a lossy reading
  of a PDF, not from structured and current data.
- **Evidence.** The best in the corpus. In PCBSchemaGen (2602.00510),
  grounding a frozen model in pin-level datasheet facts takes its verifier
  pass rate from 26.8% to 81.3%; the verifier is also the reward, but agreed
  with blind engineer labels at κ 0.91. HWE-Bench (2603.18102) shows raw
  datasheets alone are far from enough: 8.15% fully correct with them always
  supplied. The mode may be shifting: recent threads report stock problems
  (A6) more than invented parts, and A5 has no instance newer than
  2026-08-21 (`findings.md` §6).

### 2. Intent is never written down, so nothing can check it

- **Symptoms.** Function not achieved, unrelated parts wired (A1). Known-good
  circuitry rewritten unasked (A3). Fast, noisy, high-current and paired nets
  treated like any other (A4, A23 to A25). Over-design (A2). A written rule
  ignored: T13's Astra 6 run put a debug connector mid-board against "keep all
  connectors and pads near the edge".
- **Cause.** A netlist carries connectivity, not purpose. With no declared
  intent, every check downstream is blind to it, and so is the agent.

### 3. Geometry is the weak axis, not connectivity

- **Symptoms.** Nets shorted by overlapping labels while ERC only warns
  (A11). Unreadable schematics, one sheet with a label on every pin (A13).
  Backwards connectors (A16). Supporting parts far from their pins (A17).
  Mechanical misfit (A20). Spaghetti routing (A22), the commonest complaint on
  Reddit: 6 of the 7 AI-board threads in R. Silkscreen pile-ups (A30).
- **Cause.** The agent writes coordinates it cannot see. T16's author said it
  directly: the model understood connectivity better than spatial layout.
  OmniLayout (2607.03261, abstract) reports weak geometric reasoning in
  current models over 1,681 layouts.
- **Evidence for the remedy.** The best layout results in the corpus come
  when coordinates are computed rather than pushed by hand. In T13, Fable 5.2
  wrote its own routing script and finished in two iterations; Astra 6 spent
  over 30 fixing autorouter output. PCBRouteAgent (2611.08175) puts a language
  model over KiCad's own router: it plans, the router draws, and the pair
  beats both the router alone and models routing move by move.

### 4. Work runs open-loop, without backtracking

- **Symptoms.** The router retried when placement was the problem, leaving
  boards "95% complete but unusable" (A18). DRC driven to zero and called done
  (A32). Edits that are not repeatable (A34).
- **Evidence.** Three ablations, same model and tasks each time:
  - KiCad's DRC after every routing step: 0.65 clean pass @5, against 0.19
    planned up front and 0.02 with no engine (PCBWorld, 2607.05915).
  - SPICE in the loop on switched-mode supplies: o3 from 25.4% to 84.9%
    solved (2507.10639).
  - Pin-level feedback in place of pass/fail: 57.7% to 81.3% (PCBSchemaGen).

  This lever is about as well evidenced as grounding.

### 5. The checks stop at what is easy to check

- **Symptoms.** ERC and DRC clean is where most tools and claims stop. Here
  are boards from the prior-art repos that passed DRC (C, headline findings):
  five nets shorted, a drill-origin offset, plated-hole rings below the fab
  minimum, nets from the wrong revision. ERC only warned on two nets merged by
  overlapping labels (A11). EDA Bench (ICML 2026, abstract) has agents build
  21 of 35 boards that parse and look plausible, scoring 4.58% on the
  electrical behaviour they were meant to have.
- **A second-order version.** Checks that measure a proxy, not the rule they
  are named for (two repos, C's tally), and a documented case of "three
  checkers measuring the wrong thing" (1999AZZAR, C). The only defence found
  is a planted-failure self-test shipped with each check (florianuhlemann,
  alexchunlin; C, rule 12).

### 6. What the agent reports cannot be taken at face value

- **Symptoms.** Claims of work not done (A35). Renders offered as evidence
  (A37). Agreeing with whichever approach the question implies (A36). Review
  output that resembles analysis (A38). AI-written rationale contradicting the
  schematic (A39).
- **Cause.** The agent's narration is treated as the record. Success posts
  mostly stop at text or a render: of B's 36 graded claims, 15 are text only
  and 5 render only; none is measured (`findings.md` §2).

### 7. The tool layer itself can make things worse

- **Evidence.** mcp-server-kicad's authors ran plain Claude Code against
  Claude Code with their 109-tool plugin on six single edits, three runs each:
  18 of 18 right without it, 3 of 18 with it. The causes they name: missing
  verbs, an instruction never to edit files directly, and a sync tool that
  rewrote nearly every footprint (C). One unpublished design, small n.
- **A case in boardwright.** heibench/boardwright#134: the preview's ratsnest
  disagreed with KiCad on connectivity, and a reviewer read its false opens as
  open nets. A tool that is wrong misleads the agent more than no tool.

### 8. Some work is beyond the current reach

HDI, BGA and DDR (A26), EMC (A29), antenna tuning, thermal, certification, and
diagnosis at bring-up (A41, N4). No tooling in the corpus closes these. Here
the useful act is stating the limit.

### Not a cause: corners and tidiness

90° corners are graded folklore below the GHz range (E1), yet they and messy
routing are what reviewers see first (A22), and they cost a design its
credibility. They belong in a report by default, failing only where a board
or a house style asks for it, rather than in the list above.

## The layers

These are layers of the agent's toolchain, from the model up to the bench.
They are not the evaluation layers of
[`../agent-evaluation/methodology.md`](../agent-evaluation/methodology.md)
(seeded defects, measurement, human adjudication).

| layer | what belongs there | causes |
| --- | --- | --- |
| 0. model | raw capability; chosen, not built | all; T13 shows two current models far apart on one task |
| 1. information | parts with stock and lifecycle; datasheets as pin-level facts; reference designs and errata; declared intent | 1, 2 |
| 2. interface | how the agent reads and writes the design; tools compute geometry, the agent states topology and constraints; renders fed back | 3, 7 |
| 3. verification | independent engines (KiCad, SPICE, a netlist against intent, fab-file readback), with fine-grained feedback and checks that test themselves | 4, 5 |
| 4. workflow | order of work, when to back out (re-place before re-routing), edit scope, reporting the evidence rung reached | 4, 6, 2 |
| 5. human and physical | review, bring-up, measurement, certification | 8 |

## Against heibench's tools

As of 2026-11-21:

| layer | in place | missing |
| --- | --- | --- |
| 1 | declared intent: netspec's specification, boardwright's `REVIEW` | part sourcing (stock, lifecycle); datasheet facts in structured form; a reference-parts check (boardwright#123) |
| 2 | boardwright `existing` and `live`: scoped edits, every other net byte-identical | readable generated schematics (boardwright#126); geometry for routing is still Freerouting's |
| 3 | KiCad ERC and DRC; netspec (connectivity against intent); boardwright `REVIEW` placement, fab, decoupler-loop and quiet/noisy checks (#47, #49, #122, #125); gerberdiff (fab output) | simulation in the loop; self-tests shipped with checks |
| 4 | boardwright's agent skill (#48) and exit codes as the contract | the rules in boardwright#128 |
| 5 | none in software | a bring-up plan the agent hands over |

## What this suggests

These are proposals for discussion, not decisions.

1. **Layer 1 is the largest gap and the best-evidenced lever.** Nothing here
   turns a part number into a stock state and a pin-and-constraint record that
   the agent, netspec and boardwright could all read. One such source would
   bear on causes 1, 2 and 5 together.
2. **Simulation in the loop is the second.** ngspice over the power and
   analog blocks, judged against declared intent, is the one engine-feedback
   route with ablation evidence (2507.10639) that heibench does not have.
3. **Geometry belongs to tools.** The evidence favours the agent stating
   constraints and a deterministic tool computing coordinates, with renders
   fed back. Route-quality checks (boardwright#138) help the agent judge a
   result; they do not replace a tool that draws it well.
4. **Measure the tool layer against a bare agent.** Cause 7 says a tool layer
   can cost more than it adds. `agent-evaluation` holds the method for asking
   whether a tool helps an agent, with a no-tool arm and an oracle
   independent of the tool; here the arms would be the same tasks done by an
   agent with `kicad-cli` and by one with boardwright.
