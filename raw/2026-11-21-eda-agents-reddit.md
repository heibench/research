# Workstream R: Reddit harvest (sub-questions 1, 3, 5)

Captured 2026-11-21 from saved copies. Access date for every thread below:
2026-11-21 (page text saved by hand that day; not fetched by this workstream).

## Method

**Input.** 17 files, `_research_dump/reddit1.md` to `reddit17.md`, each the
page text of one old.reddit.com thread with its URL on line 1. Nothing else was
read and nothing was fetched: no reddit.com, no linked write-ups, repos or
blogs. Links inside the threads are noted, not followed.

**Skipped.** Reddit page chrome (navigation, sidebar, subreddit lists, account
and moderator lists, footer). Usernames are not recorded; claims are attributed
to "the OP" or "a reply". The text copy has no images: where a post or reply
says an image, GIF, video or gallery exists, the entry says "referenced, not
seen".

**Coverage limits found in the files.**

- `reddit10.md` has the URL of a thread about a tool called kicadgen
  (`/r/KiCad/comments/1xjp7qy/`), but its body is byte-identical to
  `reddit9.md` (the KiVi thread) apart from the trailing newline
  (`diff <(tail -n +2 reddit9.md) <(tail -n +2 reddit10.md)` differs only on
  the last line). The kicadgen thread's content is not in the capture.
  So 17 files hold 16 distinct threads.
- `reddit1.md` shows "top 200 comments" of 228 and has 15 lines matching
  `load more comments|show all|[+]` (collapsed or deleted subthreads); 172
  comment headers are visible (`grep -c '^\[–\]'`). `reddit17.md` has one
  comment collapsed as "score below threshold" (the OP's, with 2 children).
- Threads 2 to 7 are r/PrintedCircuitBoard image or link posts: the saved text
  has the title and replies but no OP body. None of them mentions AI:
  `grep -i -E '\bAI\b|claude|gpt|llm|fable|opus|gemini|copilot|chatgpt|generated'`
  over files 2 to 7 returned nothing (exit 1), while the same pattern matches
  49 lines of `reddit1.md` for "claude" alone. They are recorded as a
  baseline of reviews where AI use is not stated, not as AI boards.
- The 17 threads were chosen by the saver, not by a search this workstream
  ran. No saturation claim is possible and no rate can be read from them.

**Dates.** Every file carries an absolute "this post was submitted on" line;
that is the date used. The 3-month cutoff is 2026-08-21. Relative ages in the
files ("2 months ago", "8 hours ago") agree with the absolute dates against a
save date of 2026-11-21.

**Mapping.** Failure modes map to A's rows 1 to 44
(`A-critique-harvest.md`, "Failure modes"); new ones are numbered N1, N2 …
with a stage. Success claims use B's ladder (`B-success-claims.md`, Method):
1 render, 2 DRC/ERC clean, 3 fabricated, 4 assembled and powered, 5 tested
against function, 6 measured; **T** = text only. Because nothing is shown in a
text copy, every claim here is T as *shown*; the table also records the rung
the text *states* and whether media was referenced, and the tally is of
stated rungs.

## Threads

### T1. r/ClaudeAI, "My first ever PCB, entirely designed by Claude"

<https://old.reddit.com/r/ClaudeAI/comments/1wdgzue/my_first_ever_pcb_entirely_designed_by_claude/>
Posted 2026-09-11 (absolute; 71 days before save, inside 3 months). The OP
says the boards were ordered on 11 July, so the design work is older than
3 months.

- **Board:** RP2350 dev board sized to a 1.54" e-ink display, four buttons,
  I2C and GPIO out. Claude Fable 5 through Claude Code and a self-written
  skill driving KiCad 9 headless (pcbnew Python module plus kicad-cli), not an
  MCP server. OP reports earlier attempts with Opus 4.5 to 4.8 failed:
  components wrongly oriented, no proper routing. Same board as B rows 1-2.
- **Human share:** a one-paragraph prompt; rule of no manual edits or
  verification; caught two wrong footprints (SPI flash, e-ink driver
  transistor) as parts "not well seated on the pads" in JLCPCB's 3D viewer;
  had the agent swap parts not in LCSC stock; continuity check 3V3 to GND
  before first plug-in; wrote firmware with Opus 5. Spend stated as about
  USD 450 of API credit (OP unsure) and EUR 130 for 5 assembled boards.
- **Rung stated:** 5 (board enumerated on USB, own software drove the
  display); images and a demo GIF referenced, not seen.
- **Criticisms (replies):** a reply listed ten layout issues: 90° corners and
  needless small bends (22), point-to-point traces as an etch risk (22),
  ground-pour gaps fixable by spreading vias (N2), power traces no wider than
  signals (23, "minor on this board"), filter cap C21 not beside its pin (17),
  bends a rotated passive would remove (22), R10 near the edge (N1), top-side
  test points forcing routing compromises (N3), input filter placed off the
  signal path (17). Other replies: crystal routing (24), USB D+/D- routing
  (25), "spaghetti", "worst routing" (22); a senior EE: intern level before
  feedback, and the RP2350 reference layout should have been copied (7);
  buttons over the V-scores and parts overhanging a V-cut (N1, three
  replies); "All it did was run an auto router" (21, disputed by OP's
  description of hand routing).
- **Confirmed?** OP confirmed the two wrong footprints (15) and stock
  substitutions (6), and conceded "weird hand routing" with some 90° tracks
  left (22). Nothing else confirmed; no respin.
- **Side reports by other users of their own AI boards** (one line each, not
  this board): pull-up values wrong (8); joystick not connected on a fabbed
  board (10); netlist "wildly inaccurate" (10); one user graded their own
  harness schematic A+, part selection A++, placement C, routing F (22).
- **Praise / counter-evidence:** a professional EE: routing ugly but
  "perfectly functional with this circuit", since no power switching or fast
  buses; placement "a lot better" than other AI boards seen; several replies:
  board is simple and heavily documented by reference designs.

### T2. r/PrintedCircuitBoard, review request, ESP32 air-quality monitor + Geiger counter

<https://old.reddit.com/r/PrintedCircuitBoard/comments/1xsk1hy/review_request_esp32_based_air_quality_monitoring/>
Posted 2026-11-10 (absolute). AI use not stated. Baseline.

- Bus on L4 referencing a fragmented L3 power plane, so return current
  detours (24, reference-plane continuity); OP added a GND plane on L3:
  **agreed**. CP2102N VBUS pin needs the datasheet divider (7); OP added it:
  **agreed**. Planes far from the switchers (24, unconfirmed). HV/LV pour
  joined: OP says intentional single-point ground.
- Rung: none stated (pre-fab review).

### T3. r/PrintedCircuitBoard, ESP32-C3 LoRa board (first PCB)

<https://old.reddit.com/r/PrintedCircuitBoard/comments/1xrqysc/review_request_esp32c3_lora_board_first_pcb/>
Posted 2026-11-09. AI use not stated. Baseline.

- 3.3 V LDO drops out over part of the 1S 18650 range (7); OP switched to a
  buck-boost: **agreed**. Bulk cap at the radio module for TX current (17);
  OP added caps: **agreed**. Battery divider always drawing current (N5); OP
  says it is MOSFET-switched: disputed. Linear charger straight off a solar
  panel (7); OP disputes.

### T4. r/PrintedCircuitBoard, STM32 mini flight computer

<https://old.reddit.com/r/PrintedCircuitBoard/comments/1xzsp6c/review_request_stm32_based_mini_flight_computer/>
Posted 2026-11-18. AI use not stated. Only the moderator's standard checklist
(posted on all reviews) and one question on power distribution. No criticism.

### T5. r/PrintedCircuitBoard, ESP32-C3 battery plant sensor, 4-layer 28 × 38.5 mm

<https://old.reddit.com/r/PrintedCircuitBoard/comments/1xvn49w/review_request_esp32c3_battery_plant_sensor/>
Posted 2026-11-13. AI use not stated. Moderator checklist only.

### T6. r/PrintedCircuitBoard, ESP32-C3 wireless servo controller

<https://old.reddit.com/r/PrintedCircuitBoard/comments/1xzb27h/review_request_esp32c3_wireless_servo_controller/>
Posted 2026-11-18. AI use not stated. Moderator checklist only.

### T7. r/PrintedCircuitBoard, ESP32-C3 LoRa board, corrected design

<https://old.reddit.com/r/PrintedCircuitBoard/comments/1xum12s/review_request_esp32c3_lora_board_corrected/>
Posted 2026-11-12. Follow-up to T3. AI use not stated. Moderator checklist
only.

### T8. r/KiCad, PCB timelapse plugin

<https://old.reddit.com/r/KiCad/comments/1xfto9z/i_made_a_kicad_plugin_that_records_timelapses_of/>
Posted 2026-10-26. A KiCad plugin whose code was mostly written by Claude; the
OP tested it on their own boards. Not a board design. One reply thanks the OP
for disclosing AI use and describing the testing. No board criticism.

### T9. r/KiCad, KiVi project viewer and review tool

<https://old.reddit.com/r/KiCad/comments/1xqsbrk/kivi_kicad_project_viewer_source_control_and/>
Posted 2026-11-08. Viewer and review tool built with Claude Code (OP made the
decisions and tested). Not a board design. Replies: KiCad is adding diff
support; one calls it "vibe-coded". No board criticism.

### T10. r/KiCad, kicadgen (content missing)

<https://old.reddit.com/r/KiCad/comments/1xjp7qy/i_built_kicadgen_an_opensource_tool_to_automate/>
Saved body is a duplicate of T9 (see Method). Date and content unknown.

### T11. r/ClaudeAI, hardware-in-the-loop for Claude

<https://old.reddit.com/r/ClaudeAI/comments/1xn8gpz/hardwareintheloop_for_claude_ai_builds_the_pcb/>
Posted 2026-11-03. OP describes boards generated as Python scripts that emit
fab files only if ERC/DRC are clean and every part checks live against LCSC,
with firmware run against a simulated twin, on a multi-board motor and sensor
project over weeks. Rung stated: 2 (the ERC/DRC gate); no board, photo or
result shown. A reply asked for an example in use; no answer in the capture.
No criticism raised.

### T12. r/ClaudeAI, "Claude Fable 5.2 designed three devices … no circuit fixes"

<https://old.reddit.com/r/ClaudeAI/comments/1xtjtsp/claude_fable_52_designed_three_devices_from_short/>
Posted 2026-11-11. A repost of Anthropic's 2026-11-09 article (B row 3), with
its stated limits (no electrical validation, antenna tuning, thermal test or
certification; commercial relationship with Diode) and benchmark scores.

- A reply endorses the limits: antenna, thermal and certification work
  remain (29).
- A reply: a DIY chronograph whose PCB Opus 5.5 designed, checked by two
  other models before ordering; controllers flashed; troubleshooting line
  noise from the battery holder, cause not stated (N4, unconfirmed, in
  progress). Rung stated 4.
- A reply: Claude designed a custom PCB for them months ago; no outcome.

### T13. r/ClaudeAI, Fable 5.2 vs GPT Astra 6 layout of a motor driver

<https://old.reddit.com/r/ClaudeAI/comments/1xxnddo/fable_52_hard_mogs_gpt_astra_in_hardware_design/>
Posted 2026-11-16. The OP, who does PCB design, gave both agents the same
human-made schematic, fixed outline and mounting holes, 4-layer rules, the
same KiCad 10 MCP server, and a prompt with current and temperature-rise
targets. The board had already been designed and fabricated by the OP; the
agents' layouts were an exercise and were not fabricated.

- **Fable 5.2:** two iterations, the second fixing two traces too close
  (a clearance fault, caught and fixed). OP reports its own routing script
  instead of an autorouter, neat straight traces, power pours, stitching
  vias, parts kept on one side. Asked before starting whether KiCad had the
  file open.
- **Astra 6 (OP's findings, first-hand, no fab):** over 30 iterations, much of
  it fixing autorouter errors; debug connector placed mid-board and
  inaccessible, against the prompt's "keep all connectors and pads near the
  edge" (20, also 4); inconsistent spacing of power pads; vias in pads (N6);
  spaghetti routing (22); final board fails checks with nets unconnected (21).
- **Replies:** Astra asked the sharper electrical questions (phase vs supply
  current, stall limit); one run each is one data point; both boards have
  flaws, Fable's "hobbyist level" (not itemised).
- Rung stated: 1 for the Fable layout (described; no image referenced in the
  saved text).

### T14. r/ClaudeAI, Claude Code driving Altium through an MCP server

<https://old.reddit.com/r/ClaudeAI/comments/1xhr1ym/i_gave_claude_code_600_tools_to_drive_altium/>
Posted 2026-10-28. OP is an electronics design engineer and author of
eda-agent, an open-source MCP server for Altium (KiCad and EasyEDA backends
said to exist). Video referenced, not seen.

- **Board:** round 54 mm, 4-layer, 61 LEDs in rings, USB. Agent built the
  library (symbols, footprints, 3D models, part numbers), schematic,
  placement, routing, ground pours; DRC reported clean; Gerbers, drill, BOM,
  pick-and-place, STEP exported. Not fabricated; OP would still do a manual
  pass before prototyping.
- **OP's own first-pass review list**, fixed by the agent: USB not routed as a
  proper differential pair (25), realistic 3D models missing, schematic title
  blocks missing (N7). **Confirmed by the OP.**
- **Method stated by OP:** datasheets first, with the server reminding the
  agent at session start and every 10 calls not to guess component specs;
  wiring checked against real pins before it is drawn.
- **Replies:** connections longer than needed, an LED could be rotated, vias
  could follow a radial grid (22); capacitor placement ignores the current
  path (17); vias connected with thermal relief instead of solid (N8); batch
  edits may be repeated on retry after a partial failure (34, a question, not
  observed). None confirmed.
- Rung stated: 2.

### T15. r/ClaudeAI, Claude for technical drawings (cable assemblies, PCBs)

<https://old.reddit.com/r/ClaudeAI/comments/1xsu0wz/using_claude_for_technical_drawings_cable/>
Posted 2026-11-10. The OP's question is about drawing extraction, not board
design. One reply: their Claude-made PCB was "pretty great" on layout and
schematic, "horrible on the routing" (22), and implies it did not start once
built, advising a fresh-session review before fab (N4). Rung stated: 3, with
a functional failure; no media.

### T16. r/electronics, AI-designed Halloween prop controller

<https://old.reddit.com/r/electronics/comments/1xgzezf/managed_to_use_ai_to_design_a_fairly_complex/>
Posted 2026-10-27. Gallery referenced, not seen.

- **Board:** ESP32-S3 controller with sensor inputs, prop triggers, audio amp,
  protected 5 V PWM outputs, 5.9 to 12 V input with fused pass-through. GPT Sol
  5.6, then GPT Astra via Codex, editing raw KiCad files and calling the
  binary for DRC; no MCP server.
- **Human share:** OP (a software engineer) did most placement; AI did spec,
  part selection, datasheet sourcing and reading, most of the schematic, and
  "99.9%" of routing. Over two months; OP iterated by critiquing the agent and
  having it write skills.
- **OP-reported weakness:** connectivity understood better than spatial
  layout; schematics and routing looked like "a dog's breakfast" until
  screenshot feedback and a skill (13, 22; OP's own account).
- **Replies:** hostility to AI generally; "you didn't do any of the
  electronics". No technical criticism of the board.
- Rung stated: 5 (in use running a haunted-house prop with audio, motion and
  relays).

### T17. r/KiCad, 144-LED keychain board designed by Claude

<https://old.reddit.com/r/KiCad/comments/1y1sz6u/claude_designed_this_144led_keychain_board_in/>
Posted 2026-11-21 (8 hours before save). Images referenced, not seen. OP
discloses the board will be sold.

- **Board:** CR2032-powered keychain, CH592X MCU with native USB, 144
  Charlieplexed LEDs, 6 buttons, buzzer, fixed outline. Opus 5.5 via KiCad CLI
  with its own scripts; a later reply credits Fable 5.2 with the RF analysis.
  Agent declared the board too small for autorouting and wrote its own
  routing scripts; OP asked for parallel traces and no 90° angles.
- **Human share:** constraints; refused a larger board; watched every
  screenshot and steered over about a week and a half.
- **What the agent did (as stated):** fit check by render, MCU choice, a MOSFET
  power path chosen after studying the OP's old boards, ceramic antenna in a
  keep-out with no ground or parts on either side, an unrequested 2.4 GHz RF
  check, panelization, firmware and a simulator before ordering.
- **Outcome:** first boards did not work: the bootloader was not the one the
  chip's manual describes (40); the agent rewrote it and the board "came
  alive". Antenna untested; rev1 swaps to a printed antenna, also untested.
- **Replies:** the routing visibly has 90° angles despite the post (22, two
  replies; the OP's response is collapsed and not seen); traces look too thin
  in the render (23; another reply says copper thickness can compensate);
  radio certification cost before sale and the anechoic-chamber step (29);
  "a simple board to route by hand" (OP agrees).
- Rung stated: 4 ("came alive"; function beyond that not stated).

## Failure-mode table

Counts are threads raising the mode, counted from the thread sections above.
"AI" counts threads with an AI-made board (T1, T12 to T17); "base" counts the
baseline threads where AI use is not stated (T2, T3). Side reports in T1 from
other users' boards count under T1.

| mode | AI threads | base threads | refs | confirmed? | AI-specific? + reason |
| --- | --- | --- | --- | --- | --- |
| 4 design intent ignored | 1 | 0 | T13 | first-hand (OP observed, no fab) | AI-specific here: a written prompt rule was ignored, not unknown intent |
| 6 unavailable parts | 1 | 0 | T1 | agreed (OP) | Leans AI: chosen without a stock check; a human picking from the fab's catalogue avoids it |
| 7 datasheet / reference design not applied | 1 | 2 | T1; T2, T3 | T2, T3 agreed and fixed; T1 no | Beginner-generic: both baseline instances are human first boards |
| 8 wrong values | 1 | 0 | T1 (side report) | no | Unclear: one line, no detail |
| 10 wrong connections | 1 | 0 | T1 (side reports) | fab (joystick, per that user) | Both |
| 13 unreadable schematic | 1 | 0 | T16 | OP self-report | Both; OP ties it to weak spatial reasoning in the model |
| 15 wrong footprint | 1 | 0 | T1 | agreed, caught before order in fab 3D viewer | Both; caught only because a human looked |
| 16 part orientation | 1 | 0 | T1 (OP on earlier Opus models) | OP self-report | Leans AI: OP says it went away with a newer model |
| 17 supporting parts far from pins | 2 | 1 | T1, T14; T3 | T3 agreed; AI instances no | Beginner-generic (baseline instance present) |
| 20 mechanical / access | 1 | 0 | T13 | first-hand (OP) | Leans AI: against an explicit rule |
| 21 nets unrouted / autorouter accepted | 2 | 0 | T1 (disputed), T13 | T13 first-hand; T1 disputed | Leans AI |
| 22 ugly routing, 90° corners, spaghetti | 6 | 0 | T1, T13, T14, T15, T16, T17 | T1 partly agreed; T13, T16 first-hand; T14, T15, T17 no | Both; reviewers in T1 and T13 call spaghetti point-to-point routing the autorouter / AI "tell" |
| 23 power traces thin | 2 | 0 | T1, T17 | no; T17 rebutted by a reply | Both |
| 24 sensitive routing / return path | 1 | 1 | T1 (crystal); T2 (plane reference) | T2 agreed and fixed; T1 no | Beginner-generic (baseline instance present) |
| 25 differential pairs | 2 | 0 | T1, T14 | T14 agreed and fixed by OP's review | Both |
| 29 EMC / compliance not evidenced | 2 | 0 | T12, T17 | stated limit (T12 source); T17 no | Both; amplified when a success post leads to "on sale" |
| 34 non-idempotent edits | 1 | 0 | T14 | no (a question) | AI-specific (tool-call retries) |
| 40 datasheet grounding fails | 1 | 0 | T17 (bootloader differs from manual) | fab (boards dead until fixed) | Generic: a human following the manual hits it too |
| N1 parts at board edge or over V-score | 1 | 0 | T1 | no (three replies) | Both; stage placement / manufacturing |
| N2 ground pour fragmented, fixable with vias | 1 | 0 | T1 | no | Both; stage power delivery / EMC |
| N3 test points placed where they force routing compromises | 1 | 0 | T1 | no | Both; stage placement (DFT) |
| N4 bring-up fault, cause not stated | 2 | 0 | T12, T15 | T15 by that user; T12 in progress | Unclear: no cause given; stage bring-up |
| N5 always-on quiescent drain in a battery design | 0 | 1 | T3 | disputed by OP | Beginner-generic; stage requirements / power |
| N6 vias in pads | 1 | 0 | T13 | first-hand (OP) | Both; stage manufacturing (DFM) |
| N7 documentation deliverables incomplete (title blocks, 3D models) | 1 | 0 | T14 | agreed, fixed | Both; stage documentation |
| N8 thermal relief on vias where solid wanted | 1 | 0 | T14 | no | Both; stage routing / power delivery |

Not counted as criticism: the r/PrintedCircuitBoard moderator checklist (posted
on every review, T4 to T7); the clearance fault Fable fixed in T13's second
iteration; complaints about AI in general (T9, T16).

## Success-claim table (B's ladder)

Rung stated = what the text says; shown = what this text capture shows
(always T). Same-board duplicates of B are marked.

| # | thread | board | tool | human share | rung stated | media | note |
| --- | --- | --- | --- | --- | --- | --- | --- |
| R1 | T1 OP | RP2350 e-ink board | Fable 5 + Claude Code skill, KiCad 9 | prompt; caught 2 wrong footprints, stock swaps; firmware | 5 | images + GIF referenced | same board as B rows 1-2; continuity check before power is not a rung-6 measurement |
| R2 | T1 reply | ESP32-C3 core board (write-up linked, not followed) | Claude + Codex | "review and approval on key details" | 4 | image referenced | "the actual board works", function unstated |
| R3 | T1 reply | retro phone retrofit, several revisions | Opus 4.6 + KiCad MCP | human-led, AI as teammate | 5 | none | in use for calls |
| R4 | T1 reply | 6-axis gyro + joystick + USB-C | Claude (not named further) | not stated | 4 | none | "worked for the most part"; joystick not connected |
| R5 | T11 OP | multi-board motor and sensor project | Claude Code, Python-generated boards | direction | 2 | none | ERC/DRC gate claimed; example requested, not supplied |
| R6 | T12 reply | DIY chronograph | Opus 5.5, checked by two other models | build, debug | 4 | none | controllers flashed; noise under diagnosis |
| R7 | T13 OP | BLDC driver layout | Fable 5.2, KiCad MCP | full schematic and rules by OP | 1 | none | not fabricated; Astra 6 layout of the same board failed checks |
| R8 | T14 OP | 54 mm 4-layer LED board | Claude Code + Altium MCP | spec; review list | 2 | video referenced | DRC clean stated; not fabricated |
| R9 | T15 reply | unnamed Claude PCB | Claude | not stated | 3 | none | built; did not start |
| R10 | T16 OP | ESP32-S3 prop controller | GPT Sol 5.6, GPT Astra via Codex | most placement; iteration | 5 | gallery referenced | in use running props |
| R11 | T17 OP | 144-LED keychain | Opus 5.5 (Fable 5.2 credited for RF) | constraints; close steering | 4 | images referenced | first boards dead (bootloader); antenna untested |

Not graded: T12 OP (repost of B row 3, adds no evidence); a T12 reply and a
T17 reply that state no board outcome.

### Tally by stated rung (counted from the table above)

| rung | claims | which |
| --- | --- | --- |
| 6 measured | 0 | |
| 5 tested against function | 3 | R1, R3, R10 |
| 4 assembled and powered | 4 | R2, R4, R6, R11 |
| 3 fabricated | 1 | R9 (failed) |
| 2 DRC/ERC clean | 2 | R5, R8 |
| 1 render | 1 | R7 |
| total graded | 11 | |

Shown in this capture: all 11 are T (text only). Media referenced: 5 of 11
(R1, R2, R8, R10, R11; R2's image is in a reply).
No claim states a measurement: no scope trace, current figure, thermal or EMC
result.

**Strongest-evidence board:** R1 (T1, RP2350 e-ink board). It states rung 5,
names the two faults found, and is the one board whose photos another
workstream saw (B row 1 grades the same board 5 from its write-up). R10 also
states rung 5, but a human did most placement and no reviewer examined it.

## Within the last 3 months

All 16 distinct threads were posted inside the window: the earliest is T1
(2026-09-11, 71 days before save); the rest run 2026-10-26 to 2026-11-21. So
every finding above rests only on threads at most 3 months old by post date.
One qualification: T1's board was designed and ordered in July 2026 (OP's
statement), so its failure evidence describes Fable 5 work older than
3 months, and T1 R3's "Opus 4.6" board and the OP's failed Opus 4.x attempts
are older models still. The findings that rest on post-September work only:
T13's Fable 5.2 vs Astra 6 comparison, T14's Altium board, T16's controller,
T17's keychain, and the N6, N7, N8 rows.

## Gaps

- No images. Every layout criticism is a reply's reading of a screenshot this
  capture cannot check, and no rung above is *shown*.
- Comments truncated: T1 shows 200 of 228 with collapsed subthreads; one
  collapsed OP reply in T17 may confirm or dispute the 90° criticism.
- T10 (kicadgen) is missing: the saved file duplicates T9.
- Six of 16 threads (T2 to T7) state no AI use; three of those (T5 to T7)
  have only the moderator checklist and T4 one question besides. They give a thin baseline of two reviewed boards.
- Hand-picked sample, no search: counts say what these threads contain, not
  how common anything is. No r/ElectricalEngineering or r/AskElectronics
  critique of an AI board is in the set, though T1 replies predict one.
- Linked write-ups and repos (T1, T8, T9, T11, T14) were not followed, per
  the task.
