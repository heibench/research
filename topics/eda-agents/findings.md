# Findings: AI agents designing circuit boards

Synthesis of the 2026-11-21 captures in `raw/` (workstreams A to E and R of
[`brief.md`](brief.md)) and the verification pass V. Sources are in
[`bibliography.md`](bibliography.md); row numbers like "A17" point at a row of
the capture they name, "R:T13" at a Reddit thread, "N1" at a mode only Reddit
raised.

**Recency.** Models changed fast in this window (Fable 5 in June 2026, 5.2 by
November), so evidence older than three months may describe tools nobody
uses now. §6 says which findings still have evidence from after 2026-08-21.

**Reddit came in by hand.** Reddit's API refuses new apps and our tools cannot
reach the site, so R read 17 threads saved by hand (16 distinct; one file
duplicated another), all posted 2026-09-11 to 2026-11-21. They were picked
from top-of-month searches, not sampled: their counts say what those threads
contain, not how common anything is. The text copies carry no images.

## Headline

1. **The critics are mostly right about evidence, partly right about
   technique.** No board in any capture was measured: no scope trace, current,
   thermal or EMC result (B, 36 claims graded; R, 11; D, 18 papers). Of the 19
   technique criticisms E took to vendor and practitioner sources, 4 hold for
   ordinary boards, 12 only past a stated condition, 2 are folklore and 1
   found no source either way (E, count corrected by V). 90° corners and split analog/digital
   grounds are the folklore; decoupler loops, crystal placement, reference-gap
   crossings and switcher hot loops are real.
2. **What goes wrong with agents is mostly upstream of layout.** A's 44 modes
   cluster in part selection (hallucinated, obsolete, wrong facts asserted
   against the datasheet: A5 to A9), schematic mechanics (labels overlapping
   into shorts that ERC only warns about, invented pin numbers: A11, A12),
   placement the agent will not revise when routing fails (A18), and claims
   of work not done (A35). Layout criticisms are real but are the ones a
   human beginner makes too. On recent Reddit threads the commonest
   complaint is still the visible one, ugly or spaghetti routing (A22, 6 of 7
   AI-board threads in R), and reviewers there call point-to-point spaghetti
   the "tell" of an autorouter or an agent.
6. **Head-to-head, the newest models differ more than the tools.** One PCB
   designer gave Fable 5.2 and GPT Astra 6 the same schematic, rules and
   KiCad MCP server: Fable 5.2 finished in two iterations with its own routing
   script, pours and stitching; Astra 6 took over 30, mostly fixing
   autorouter errors, ignored an explicit placement rule and ended with nets
   unconnected (R:T13; one run each, not fabricated).
3. **Grounding in the datasheet is the best-evidenced lever.** In
   PCBSchemaGen's ablation, removing datasheet-derived grounding costs 54.5
   points of verifier pass rate (81.3% to 26.8%); replacing pin-level feedback
   with pass/fail costs 23.6 (V corrected D here). Its verifier is also its
   reward, but it agreed with blind engineer labels at κ 0.91 (D, 2602.00510).
   In switched-mode power design, simulation feedback did more than
   retrieval: o3 25.4% alone, 44.1% with retrieval, 84.9% with SPICE (D,
   2507.10639). Engine feedback after every routing step: 0.65 clean pass @5
   against 0.02 with no engine, while Freerouting alone scored 0.80 on the
   same set (D, 2607.05915).
4. **A tool layer between the agent and KiCad can make it worse.**
   mcp-server-kicad's authors tested their own 109-tool plugin against plain
   Claude Code with KiCad installed: 18 of 18 single edits right without the
   plugin, 3 of 18 with it. Causes they name: missing verbs, an instruction
   never to edit files directly, and a sync tool that rewrote every footprint.
   One unpublished design, small n, but read directly from their README (C;
   re-read 2026-11-21). boardwright is such a layer.
5. **Prior art states more than it checks, and nothing has been built and
   tested.** 17 skill and MCP repos: none shows a board fabricated and tested
   (C). The checked rules worth copying are a datasheet reference-parts check
   (jvanderberg `refparts.py`) and a decoupler-fed-through-the-plane check
   (florianuhlemann D5). kicad-happy's EMC rules warn but cannot fail by
   default (V corrected C).

## 1. Failure modes, graded, and who catches them

"Grade" is E's, where E graded the criticism; "—" where it is a defect rather
than a contested rule. "Catcher" is sub-question 4: **KiCad** (ERC/DRC with the
right rules), **netspec**, **REVIEW** (boardwright's existing review), **new
check**, or **skill** (judgment, guidance only). "AI?" is A's judgement:
**AI** (agent-specific or much more frequent), **both**.

| mode (A rows) | grade | AI? | catcher | boardwright today |
| --- | --- | --- | --- | --- |
| Function not achieved, unrelated parts wired (A1) | — | AI | netspec, against intent written before the schematic | netspec is the gate; intent is the user's |
| Over-design, more layers or parts than needed (A2) | — | AI | skill | none |
| Known-good circuitry changed unasked (A3) | — | AI | netspec baseline; boardwright rule 2 | `existing` edits one block, byte-identical elsewhere; `verify` cannot yet tell which nets an edit touched (#44) |
| Intent the netlist does not carry: fast, noisy, paired, high-current nets (A4) | — | both | skill: declare it in `REVIEW` | `REVIEW` is that channel; nothing makes the agent fill it |
| Hallucinated or obsolete parts, wrong part facts (A5, A6, A8) | — | AI | skill: source each part from a distributor page and its datasheet | no part sourcing (`gaps.md`) |
| Datasheet constraint not applied (A7) | — | both | **new check**: reference parts per IC, each citing its datasheet figure | none; guide says "read the vendor document" |
| Ratings and derating not checked (A9) | — | both | skill | none |
| Wrong connections, misread reference (A10) | — | both | netspec | covered where intent is declared |
| Shorts or opens from drawing mechanics, ERC only warns (A11) | — | AI | KiCad ERC, with label-overlap warnings treated as failures; netspec | **to check**: what `verify` does with ERC warnings |
| Invented pin numbers (A12) | — | AI | KiCad ERC and netlist parity | `sch` takes pins from the library symbol |
| Unreadable schematic: one sheet, labels on every pin (A13) | — | both | skill; generator | boardwright **does this itself** for generated boards (`gaps.md`: "One flat schematic sheet, label-per-pin") |
| Malformed files (A14) | — | AI | KiCad | covered: KiCad loads and judges every result |
| Wrong footprint or package (A15) | — | both | **new check**: footprint pad count and pitch against the datasheet package | `update` swaps only same-pad footprints; no datasheet check |
| Connector or polarised part reversed (A16) | — | both | skill; preview | `preview.png` exists; nothing asks the agent to look |
| Supporting parts far from their pins (A17); decoupler loop (E2) | REAL | both | REVIEW, extended | `near` (centre distance) and `via_near` (straight-line to a via); **not** the cap-to-via trace length E2's sources rank first |
| Placement blocks routing, agent does not re-place (A18) | — | AI | skill; placement checks | `FR_ATTEMPTS` varies router cost, not placement; placement review is #47 |
| RF keep-out violated (A19) | — | both | KiCad DRC, with the module's keep-out declared | `KEEPOUTS` exist; nothing prompts their use |
| Nets left unrouted (A21) | — | AI | KiCad DRC | covered: completion pass; refuses an unfinished net (#110) |
| Ugly routing, 90° corners (A22) | FOLKLORE below ~GHz (E1) | both | none electrically; skill if cosmetic | none needed |
| Power traces too thin (A23) | CONDITIONAL (E10) | both | REVIEW | `current` (IPC-2221 width); E10 notes IPC-2152 differs |
| Sensitive trace beside a noisy node (A24); switcher layout (E12) | REAL | both | **new check**: minimum distance between declared quiet and noisy nets | `maxlen`/`maxpath` bound length, not separation |
| Differential pairs wrong (A25); per-interface skew (E4, E5) | CONDITIONAL | unknown | REVIEW with sourced per-interface limits | `match`, `ref`, `si.pair`; `skew` is total copper ("crude"); no per-interface limits |
| Reference-plane gap crossed (E7) | REAL | both | REVIEW | `ref` measures length off a ground reference |
| Split ground planes (E6) | FOLKLORE as default | both | skill: do not split by default | none needed |
| Crystal placement (E11) | REAL | both | REVIEW, extended | `maxpath`; no foreign-track keep-out under the crystal |
| Via stitching beside layer changes (E8) | CONDITIONAL | — (no AI instance found) | REVIEW | `via_gnd` |
| HDI, BGA, DDR beyond reach (A26) | — | n/a | out of scope; state the limit | not supported |
| Leftover vias, dangling copper (A27) | — | AI | KiCad DRC | covered by DRC |
| EMC not evidenced (A29) | — | both | out of scope; report honestly | guide says a clean review is not a built board |
| Silkscreen overlaps (A30) | — | both | KiCad DRC | text placed by hand (`gaps.md`) |
| Fab files and rule set-up wrong (A31) | — | AI | KiCad DRC with the fab's rules; gerberdiff | fab output and DRC in the build |
| DRC passed in a loop and called done (A32) | — | both | skill; evidence reporting | gate is DRC **and** review; still nothing stops "done" at DRC 0 on an existing board without a `REVIEW` |
| Non-repeatable edits (A34) | — | AI | tool | `apply` repeatable (#114); Freerouting not (#1) |
| Claims of work not done (A35); renders as evidence (A37) | — | AI | tool contract; skill | exit codes are the contract (0/1/2/4/64) |
| Sycophancy in design advice and review (A36, A38) | — | AI | skill: decide from sourced rules, not the question's framing | none |
| Datasheet unreadable or not reached (A40) | — | AI | skill: say which documents were read | none |

Seeds with no AI-board instance in 72 threads: split planes and wrong via
stitching (A). Both appear in the human beginner baseline.

Modes only the Reddit threads raised (R), one or two threads each, none
confirmed by a fault on a built board unless noted:

| mode | AI? | catcher | boardwright today |
| --- | --- | --- | --- |
| N1 parts at the board edge or over a V-score | both | KiCad DRC (edge clearance), with the panel's score lines declared | edge clearance via DRC rules |
| N2 ground pour fragmented | both | REVIEW | `coverage` and one-piece `ZONES` check |
| N3 test points forcing routing compromises | both | skill | none |
| N4 board fails at bring-up, cause not stated | unclear | out of scope | none |
| N6 vias in pads | both | KiCad DRC, if the fab forbids it | DRC rules |
| N7 title blocks and 3D models missing | both | skill | none |
| N8 thermal relief on vias meant to be solid | both | KiCad zone settings; REVIEW | `current` checks width, not via connection style |

## 2. Success claims

From B's 36 graded claims (recounted by V), highest rung shown:

| rung | claims |
| --- | --- |
| 6 measured | 0 |
| 5 tested against its function | 2 (one board and its press coverage) |
| 4 assembled and powered | 4 (3 vendor content) |
| 3 fabricated | 1 |
| 2 DRC/ERC reported clean | 9 (5 vendor) |
| 1 render only | 5 |
| T text only | 15 |

R's 11 Reddit claims, by the rung each *states* (the text copies show no
media, so every one is text-only as shown): 5 tested 3, 4 powered 4,
3 fabricated 1 (it did not start), 2 DRC clean 2, 1 render 1, 6 measured 0.
Two R:T17 boards were dead on arrival until the agent rewrote a bootloader
the chip's manual described wrongly; one R:T15 board never started.

The best-evidenced board is a 4-layer RP2350 e-ink watch (Fable 5, designed in
July 2026; R:T1 and its author's blog): assembled and running, with 65 DRC
errors and two wrong packages admitted along the way. Where a source
documented its own review, the review found faults DRC had passed or does not
check. V did not open images, so the photo-based rungs (B rows 1, 3, 4, 6, 7,
14) are as B read them.

## 3. Method: grounding, feedback, representation

- **Datasheet grounding: ablation evidence, one paper.** §Headline 3. The
  strongest single result, with the oracle caveat stated there.
- **Engine feedback: comparison evidence, two papers.** SPICE in the loop
  (2507.10639) and DRC after each routing step (2607.05915) both beat the
  open-loop arm by wide margins. Neither built hardware.
- **Code-first (atopile, tscircuit, SKiDL) against driving KiCad directly: no
  comparison exists.** Every claim either way is opinion (D).
- **A tool layer can cost accuracy.** §Headline 4.

## 4. Prior art

17 repos read at recorded SHAs (C). Roughly 134 rules checked by a script, 100
stated in prose, 13 measured without pass/fail, by C's rough tally before V's
correction moved kicad-happy's EMC rules to warn-only. None shows a
fabricated and tested board; KiCAD-MCP-Server #138 mentions an ordered board
with no result. Checked ideas worth taking as ideas, written in our own code
if adopted:

- **Reference parts per IC** (jvanderberg `refparts.py`): the agent writes
  each IC's typical-application parts with the datasheet figure cited; the
  script fails MISSING, WRONG VALUE or FAR. It turns "hand it the datasheets"
  into a check that can fail.
- **Decoupler fed through the plane** (florianuhlemann D5, a blocker): walking
  the tracks from the pin must reach the capacitor before any via.

Commercial tools (D): Circuit Mind's AVE checks schematics against datasheets
(vendor claim); Flux, Quilter and others show boards, none with measurements.
A human designer's ranking of seven boards diverged from four model
reviewers' in the middle of the field (alexchunlin #11, C).

## 5. Implications for boardwright

**Proposed checks** (not filed; each for review):

1. **Decoupler loop length.** Measure the routed length from each declared
   decoupler pad to its own-net via, and fail when the pin is fed through the
   plane before the capacitor. Thresholds from TI SPRABV2 §3 and SZZA009
   §2.2.4. Extends `via_near`.
2. **Reference parts.** A `REVIEW` entry per IC listing its datasheet
   typical-application parts with the document and figure, checked for
   presence, value and distance. Rule 4 ("numbers carry their source") already
   asks for the citation; this makes it executable.
3. **Per-interface pair limits.** Named presets for `match` with sourced
   limits (USB FS, USB HS, 100BASE-TX/GbE MDI, MIPI CSI: E4), and `skew`
   replaced or retired, since it compares total copper.
4. **Quiet/noisy separation.** Minimum distance between a declared sensitive
   net (regulator feedback, crystal) and a declared noisy net (switch node),
   and no foreign track under a crystal (E11, E12).
5. **ERC warnings that are shorts.** Find out what `verify` does with
   label-overlap warnings; if it passes them, make them fail (A11).
6. **Generated schematics people can read.** boardwright's own flat,
   label-per-pin sheet is A13's complaint. A generator change, not a check.

**For the tool itself:** finding 4 says a tool layer that forbids direct
edits, or lacks a verb, makes the agent worse. boardwright should be measured
against a plain agent with `kicad-cli` on the same tasks, which is what
[`../agent-evaluation/methodology.md`](../agent-evaluation/methodology.md) is
for.

**Proposed skill rules** (boardwright#48), each traced:

- Before choosing a part, read its datasheet and reference layout, check it is
  active at a distributor, and cite both (A5 to A8, A40; §Headline 3).
- Declare intent in `REVIEW` before routing: fast, noisy, paired and
  high-current nets (A4, A23 to A25).
- One decoupler value per pin, 0.1 to 0.2 µF in the smallest package, plus
  bulk, unless the datasheet says otherwise; do not add mixed small values
  (E3, SPRABV2 §2.1).
- Do not split ground planes by default (E6). Do not spend effort on 90°
  corners below the GHz range (E1).
- When routing fails, change placement before retrying the router (A18).
- Look at `preview.png` for reversed connectors and parts far from their pins
  (A16, A17).
- Report the highest evidence rung reached (render, DRC clean, fabricated,
  powered, tested, measured), never "done" (A32, A35, A37; §2).
- Decide from a sourced rule, not from how the question was framed (A36).

## 6. What still holds in the last three months

A mode counts as current when at least one instance in A or R is dated after
2026-08-21. A's instances were dated from their thread dates, and Hacker News
items by number (item 49198464 is 2026-08-06, 49569366 is 2026-09-04;
49,400,000 was taken as the cut). This is a script over A's table, so it says
an instance exists, not that the mode is still common.

- **Current:** 37 of A's 44 modes, and every mode R raised.
- **No evidence newer than three months:** hallucinated parts (A5), ratings
  and derating unchecked (A9), unloadable files and silent tool failures
  (A14), analog instability from AI advice (A28), BOM errors (A33), claims of
  work not done (A35), AI-written rationale contradicting the schematic
  (A39). Hallucinated parts in particular may be a fault of older models;
  recent threads report stock problems (A6) rather than invented parts.
- **Current only through a source describing older models:** placement not
  revised when routing fails (A18). Its recent source, Anthropic's article,
  calls it a pre-Fable-5.2 problem; R:T13 shows Astra 6 still retrying the
  router rather than re-placing.

## Corrections applied from V

V checked 62 claims against primary sources: 55 confirmed, 4 distorted, 3
wrong (V's table). This file uses the corrected values:

- PCBSchemaGen: grounding 54.5 points, pin-level feedback 23.6 (D said "about
  as much").
- kicad-happy EMC rules: warn only, fail under `--strict` at error severity (C
  said checked).
- PCBWorld figures are @5, best of five rollouts.
- E's grade count is 19 rows: REAL 4, CONDITIONAL 12, FOLKLORE 2, ungraded 1
  (18 graded technique rows plus acid traps).
- B row 32's board was built and works after a footprint fix; B row 30's
  commenter is tscircuit-affiliated.
- HWE-Bench's text and tables agree; the RF paper gives no corner angle.

## Gaps

- **Reddit is a hand-picked set of 16 threads**, text only. The saved file
  for kicadgen duplicated another thread. Six threads state no AI use and
  serve only as a human baseline. Linked write-ups were not followed.
- **Primary sources not reached** for grading: ADI MT-031/MT-101, ST AN2867,
  Ott, Microchip AN2648; IPC-2221/2152/2141 not read directly (E).
- **Saturation** in A was reached on threads several of which were loosely on
  topic (A).
- **Images** in B not opened by V.
