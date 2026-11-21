# Workstream B: success-claim audit (sub-question 5)

Captured 2026-11-21. Every URL below was accessed on 2026-11-21. Window
2025-01-01 to 2026-11-21. Reddit was not fetched; Reddit-origin claims are
recorded only as relayed by another source and marked so.

## Method

**Ladder.** Highest rung with evidence *shown* on the page, not claimed:
1 render or screenshot only; 2 DRC/ERC reported clean; 3 fabricated (photo of
bare board); 4 assembled and powered up; 5 tested against its function;
6 measured (scope, current, thermal, EMC). Two labels sit outside the ladder:
**T** = text-only claim, nothing shown (below rung 1; the brief caps these at
"1 or 2 at most", and they show less than a render); **—** = not graded
(page not readable, or not a board-design claim). A result stated in prose or
a table without a photo or plot is noted in the evidence column but does not
lift the rung.

**Sources and queries.**

- Hacker News, Algolia API, `created_at_i>1735689600` (2025-01-01).
  20 story-only queries (e.g. "AI designed PCB", "Claude PCB", "KiCad MCP",
  "atopile", "tscircuit", "Quilter", "vibe coded PCB") returned 408 unique
  hits; 18 story+comment queries (e.g. "PCB designed by Claude", "LLM PCB
  layout", "AI PCB first try", "JLCPCB AI") returned 542 unique hits, of which
  128 matched a PCB/KiCad term plus an AI term and were read as snippets.
  Then every comment in 8 threads (44542880, 46294254, 49569366, 49610059,
  49695689, 50085553, 50317331, 49020219) was filtered for a fab/works term
  plus a model/tool term: 76 comments, all read. 14 comments were read in full.
- Hackaday: site search ("claude pcb", "AI designed board") and the one
  matching 2026 article with its comments.
- EEVblog: "Claude Code for pcb design?" (EDA board, all 5 pages read) and
  "AI PCB layout" (Chat board, 1 page).
- KiCad forum: "Open AI claims GPT-6 Astra can make pcb boards" (page 1) and
  "KiCad Agentic MCP" thread (page 1).
- GitHub (`gh search repos`): "PCB designed by Claude", "AI designed PCB
  KiCad", "designed by Claude KiCad" returned 0 (the search itself returned a
  known repo when checked); "claude pcb" returned 9 repos, 2 relevant READMEs
  read. Repos linked from HN read with `gh api`.
- Vendor pages: JLCPCB blog (4 posts), Quilter (2), Flux (home, blog index),
  Copperhead, Diode, atopile/EEBench, StationX, AnyPCBA (dev.to), Anthropic.
- Web search (8 queries) for personal blogs, YouTube write-ups, arXiv.
- arXiv API: the six IDs in the brief plus 2606.01188; only 2608.31006
  describes a physical board.

**Count examined:** 45 claims or candidate claims (rows below), of which
36 are graded on the ladder and 9 are not.

## Claims table

Vendor content is marked **[vendor]**. "Human share" is what the source says
the human did; "not stated" means the source does not say.

### Write-ups, repos and vendor posts

| # | project | URL | tool | human share | complexity | highest rung shown | evidence note | later failure / respin |
|---|---|---|---|---|---|---|---|---|
| 1 | Fable 5 e-ink watch board (RP2350A, 1.54" EPD), 2026-09-04 | https://a6mzero.com/posts/this-pcb-is-brought-to-you-by-fable-5/ | Claude Fable 5 via KiCad MCP; Freerouting, then Claude hand-routed the rest | Prompt; rule "no manual edits or verification"; relayed a 65-error DRC to the agent on a colleague's advice; uploaded to JLCPCB; wrote apps | 4-layer, 31.8 × 37.3 mm; ~65 footprints, 54 nets (as stated); QSPI flash fastest named | **5** | Renders, factory and assembled-board photos, photos of watch face, menu, stopwatch, e-reader and photo-album apps running. No post-fix DRC report, no electrical measurements | SPI flash package (SOIC-8 wide vs SOP-8 pads) wrong, swapped for another part at JLCPCB upload; boost switch transistor package also wrong, fix not stated; 49 nets left by Freerouting; author calls back-side routing "horrendous". No respin reported |
| 2 | Same board, press coverage of the Reddit post, 2026-09-11 | https://wccftech.com/claude-fable-5-ai-custom-pcb-design-demonstration/ | as #1 | as #1; caption "Freerouting + hand-routed" unexplained against the no-edit rule | as #1 | **5** (duplicate of #1) | Reddit original via Wccftech; photos of board on display. $450 API credits, €130 for five assembled boards (as stated) | "far from perfect", component mistakes (stated, no list) |
| 3 | Anthropic + Diode: speakerphone, voice hub, virtual pet, 2026-11-09 **[vendor]** | https://www.anthropic.com/research/claude-electronics-design | Claude Fable 5.2 with Diode design software; KiCad router plus a Claude-written grid router | Diode engineers assembled, ran firmware under Claude's direction; prompting "minimal" | Two boards stated 4-layer; hub has 100-pin connector, USB and Ethernet pairs; speakerphone has BLE with PCB antenna; part counts not given | **4** | Schematics, copper views, photos of finished devices. Function asserted ("worked without circuit fixes", speakerphone in use for weeks) but no test data. Resonance figures are calculations. Page says no electrical validation, antenna tuning, thermal test or certification was done | No hardware respin reported; hub traces deleted and rerouted "dozens of times" during layout |
| 4 | Quilter "Project Speedrun", i.MX 8M Mini SOM + baseboard, Dec 2025 **[vendor]** | https://www.quilter.ai/project-speedrun | Quilter (physics-driven layout, not an LLM); layout only | Engineer prepared design and constraints from NXP's reference; 38.5 h human vs 27 h tool run (as stated) | 8-layer HDI, 843 components, 5,141 pins (as stated); LPDDR4 (page also says "DDR4"), GbE, PCIe, HDMI | **4** | Gallery photos of fabricated/assembled boards (Sierra Circuits). Boot to Linux claimed; no test data, DRC, SI or thermal results. HN replies note the schematic came unchanged from NXP's reference design (https://news.ycombinator.com/item?id=46296255) | Claims "no respins"; cleanup of PDN pours, via clusters, footprint swaps |
| 5 | Same project, press coverage, 2025-12 | https://www.tomshardware.com/tech-industry/artificial-intelligence/dual-pcb-linux-computer-with-843-components-designed-by-ai-boots-on-first-attempt-project-speedrun-was-made-in-just-one-week-and-required-less-than-40-hours-of-human-work | as #4 | as #4 | as #4 | — (duplicate of #4; not fetched, title and HN thread only) | — | — |
| 6 | Koppar LTE modem (EC25 + RP2040 USB audio + hub), Oct–Nov 2026 **[vendor: Koppar]** | https://github.com/Koppar-AI/koppar-lte-modem (REVIEW.md, pushed 2026-11-14) | Koppar (spec-to-board generator, MCP) | Human audited every net against datasheets and wrote REVIEW.md; who made the Rev B fixes is not stated | 4-layer, 85 × 65 mm; USB 2.0 HS hub; LTE RF 698–2690 MHz with two U.FL feeds; part count not given | **4** | Photos of bare and assembled boards. REVIEW.md reports in text: DRC 0 errors; hub enumerates at 480 Mb/s; 12 MHz crystal 12000 kHz on a counter; 3V8 buck 3.90 V no load; USB-audio loopback −12 dBFS in, −12.7 dBFS back. Core function (LTE calls/SMS/data) untested: module not fitted | First version: 35 Ω antenna feed hopping layers, buck 60 mm from its inductor, SIM socket facing inward, 90 vias in pads, 3 A path through a 0.1–0.24 mm neck; fixed before order. Built boards lack recovery pads (exported before they were added). Open: SIM card-detect wired backwards |
| 7 | usb-imu / hub_imu (STM32F042 + BNO055), Oct 2026 | https://github.com/ckemere/usb-imu (linked from https://news.ycombinator.com/item?id=50118358) | Claude Fable 5.1, KiCad python API + Freerouting (per the HN comment) | Per the comment: reviews output, points out weaknesses, routes some traces himself | Small module 21 × 14.4 mm; layers not given; USB FS | **4** | One photo of the assembled module stacked on a hub; README status "Built and working"; README does not mention AI | None listed |
| 8 | GigaShield v0.4 level-shifter shield, 2026-04-19 | https://tinycomputers.io/posts/what-routing-314-nets-taught-me-about-ai-assisted-pcb-design.html | Claude Code driving a Python → pcb-rnd generator + Freerouting | Large: workflow, Freerouting experiments, layer workaround, PCBWay submission; Claude audited and suggested placement | 314 nets, 10 × SN74LVC8T245, 155 × 90 mm, 6-layer export | **2** | PCBWay DFM screenshot, pcb-rnd DRC (121 violations judged false positives). Boards in transit | v0.3 failed on a header pin-numbering mismatch (AI involvement in v0.3 not stated); earlier Fiverr design failed on tri-state bus |
| 9 | JLCPCB: XL4015 buck with Claude Code + kicad-mcp-pro, 2026-10-14 **[vendor]** | https://jlcpcb.com/blog/kicad-mcp-how-to-design-a-pcb-with-claude-code | Claude Code, kicad-mcp-pro, Claude-written grid router | Reviewed reference against datasheets (4 problems); pin-by-pin netlist check found an ERC-missed short | 2-layer, 63 × 33 mm, 16 nets | **2** | 0 ERC, 0 DRC shown; renders. Not fabricated | 7 issues listed: op-amp units stacked, ISENSE–ISET short via label collision (ERC warning only), feedback trace beside switch node, router clearance 0.35 vs 0.5 mm rule |
| 10 | JLCPCB: CH32V006 component tester in EasyEDA Pro, 2026-10-13 **[vendor]** | https://jlcpcb.com/blog/claude-code-pcb-design | Claude Code (Opus 5.5) via EasyEDA API bridge + Freerouting | Created project, approved 8 substitutions, pasted DRC log back | 2-layer, 47 parts, 33 nets, 28 vias (as stated) | **2** | Schematic and PCB DRC 0 errors; screenshots. Headline says "working PCB"; body says no one visually reviewed the routed layout; not fabricated | 6 missing GND connections found and fixed; open pinout and polarity questions |
| 11 | JLCPCB: GPT-6 Astra TPA3116D2 amp in KiCad, 2026-09-14 **[vendor]** | https://jlcpcb.com/blog/gpt-6-astra-pcb-design-in-kicad | GPT-6 Astra (computer use) | Brief, reference files, six prompts | 2-layer, 44 × 34 mm, 40 fitted parts | **2** | 0 ERC/DRC with 9 check categories disabled; renders; Gerbers exported. FAQ says routing was reused from an earlier task. Not fabricated | Not built |
| 12 | JLCPCB: GPT-6 Astra amp in EasyEDA Pro, 2026-09-15 **[vendor]** | https://jlcpcb.com/blog/gpt-6-astra-pcb-design-in-easyeda-pro | GPT-6 Astra + Freerouting | Brief, environment, one impedance answer | 2-layer, 40 parts, 51 vias | **2** | 0 DRC in KiCad and EasyEDA; 3D renders; "has not been fabricated, assembled, or measured" | 50 import mismatches fixed; a ground segment dropped on import |
| 13 | StationX "Blink" 555 badge, Jul 2026 **[vendor]** | https://app.stationx.net/articles/ai-pcb-design | Unnamed AI assistant with KiCad 10 and a Python generator | One instruction; no edits | Coin cell, TLC555, 2 LEDs | **2** | Renders; DRC 5 violations then 0 (text); simulated 1.46 Hz. Order pending | Via 0.0285 mm from a pad; courtyard violations; a 150.4 % duty cycle reported then corrected |
| 14 | Samtec high-speed connector breakout on RO4350B, 2026-11-04 | https://www.eevblog.com/forum/eda/claude-code-for-pcb-design/msg6396965/ | Claude Opus 5.5, wrote its own field solver for trace geometry | Uploaded datasheets, general guidance, ordered; no layout changes requested | Layers and data rate not stated | **3** | Photo of received bare boards, layout screenshot, stackup image. "haven't tested the boards yet" | None yet |
| 15 | GNSS L1 active antenna (patch + SAW + 2-stage LNA), arXiv 2608.31006, 2026-08-31 | https://arxiv.org/abs/2608.31006 | Claude Fable 5 in Claude Code, scripting CST, ADS, KiCad | Spec (prescribed transistor), trade-offs, design reviews | 2-layer, 120 × 120 mm, 18 nets | **1** | Simulation results and layout figures; paper says all figures are simulated, prototype pending fabrication | Axial-ratio search stuck until a 2-D search; bias point violated VCEO; a tee simulated as a crossing, caught by human review |
| 16 | KiCad Agentic MCP demo (regulator + 2 caps), 2026-08-27 | https://forum.kicad.info/t/kicad-agentic-mcp-an-ai-assistant-that-edits-your-board-through-kicads-own-api-and-lets-kicad-decide-whether-the-result-is-good/71403 | KiCad Agentic MCP + Claude | Chose start board, prompt | 3 parts, 5 unconnected items | **2** | `kicad-cli` DRC: 5 unconnected → 0, no DRC errors | A reply says the agent "already did" make bad decisions, no detail |
| 17 | claude-pcb, RP2350A Pico-compatible, 2026-11-10 | https://github.com/GOROman/claude-pcb (docs/LOG.md) | Claude Fable 5.2, Python generators for .kicad_sch/.kicad_pcb | Owner decided USB-C vs mounting-hole conflict | 4-layer, 21 × 51 mm, 53 parts (as stated), QSPI flash, USB 2.0 FS | **2** | Log reports ERC 0 electrical, DRC 0 unconnected/0 clearance, 26 courtyard warnings (text) | Log records the agent deleting three decoupling capacitors, a VBUS 1 µF and a VINA 0.1 µF and dropping the VSYS-sense FET to make routing fit. Not fabricated |
| 18 | atomic14 "Vibe-Coding a PCB", ESP32-S3 dev board, 2025-07-12 | https://atomic14.substack.com/p/vibe-coding-a-pcb-surprisingly-good | atopile + Claude | Detailed prompt with LCSC parts and USB pins; swapped EN resistor, added ground fills, "tidied up the layout" | ~21 parts, USB FS | **1** | KiCad screenshots only. Later "dev board assembly" post (2025-11-13) is a different, human-designed board | Nothing wired at first; EN capacitor missing; 330 Ω instead of 10 k. HN reply calls the layout "very bad" (min-width power trace) |
| 19 | atomic14 twelve ESP32 dev boards from one generator, 2026-08-03 | https://atomic14.com/2026/08/03/twelve-dev-boards-from-one | Claude-written deterministic generator (kicad-skip, KiCadRoutingTools); Claude declined to design with agents | Wrote module pages and rules, reviews every render | 12 two-layer boards, USB-C, LDO, 3 LEDs, USB pair | **2** | Renders, validation PDF, 0 DRC, CI green, Gerbers released. No boards received | Pipeline failures (pour silently unfilled, version stamp fallback), fixed |
| 20 | Copperhead "Open Telegraph" ESP32-S3 Morse key **[vendor]** | https://copperhead.sh/ | Copperhead agent | not stated | ESP32-S3, USB-C | **1** | Render from KiCad files; no build evidence despite "Built on a real board" heading | — |
| 21 | OpenAI GPT-6 Astra KiCad layout demo, 2026-09-04 **[vendor]** | via https://www.quilter.ai/blog/llm-pcb-layout-gpt-6-astra and https://hackaday.com/2026/09/05/can-ai-now-design-pcbs-that-just-work/ | GPT-6 Astra | not stated | not stated | **1** | 15-second condensed video of layout (secondhand; OpenAI page not fetched). Called "manufacturable"; no fab or test shown | — |
| 22 | AnyPCBA: DeepPCB vs Quilter autorouting three open designs, Jun 2026 **[vendor]** | https://dev.to/anypcba_official/i-let-ai-design-a-pcb-heres-how-it-went-5e41 | DeepPCB, Quilter (routing only) | Imported netlists; manual cleanup of leftovers | up to 414 nets | **1** | Charts of completion and via counts | Thin traces, acute angles, via overuse; an AI BOM split one part in two; a footprint misread put power pins on ground |
| 23 | Flux homepage, "Walkie One" cellular board testimonial **[vendor]** | https://www.flux.ai/p | Flux | not stated | cellular | **T** | One-line testimonial "manufactured and tested"; agent's share not stated. Blog index (https://www.flux.ai/p/blog) lists no agent-designed board that was built | — |

### Forum and comment claims (first-hand, text only unless noted)

| # | project | URL | tool | human share | complexity | highest rung shown | evidence note | later failure / respin |
|---|---|---|---|---|---|---|---|---|
| 24 | LED earring: RP2350, IMU, 45 addressable LEDs, coin cell, 2026-09-05 | https://news.ycombinator.com/item?id=49572155 | Claude Fable | Experienced designer (15+ years, as stated); 6 days of agent use | as stated | **T** | "They work great!" | Two footprint errors: coin-cell holder missing through-holes (JLC swapped to SMD part), centre pad too small (solder added) |
| 25 | VGA image generator from 74-series logic and GALs, 2026-09-04 | https://news.ycombinator.com/item?id=49570096 | Claude Opus 4.8 | AI did circuit and GAL code; human routed | 74-series + GAL, 640×480 VGA | **T** | "works just fine otherwise" | One uncaught error, blue-wired |
| 26 | Unnamed board made in Claude Code, 2026-09-04 | https://news.ycombinator.com/item?id=49570381 | Fable or Sol (poster unsure) | Picked routes from benchmarked autorouters, some changes | not stated | **T** | "The board works" | Mistakes by both, fixed with soldering; one datasheet was wrong |
| 27 | FPV video-transmitter breakout boards, 2026-09-04 | https://news.ycombinator.com/item?id=49569871 | not named ("this same workflow") | Hand-soldered non-stock parts | "ridiculously simple" (as stated) | **T** | DRC passing, fab, "Works exactly to design" | — |
| 28 | Two PCBs from a Claude-written KiCad generator, 2026-09-08 | https://news.ycombinator.com/item?id=49616669 | Claude | Human did placement and routing | not stated | **T** | Fabricated at PCBWay, "both work" | — |
| 29 | Two PCBs, one "pretty complex", 2026-09-06 | https://news.ycombinator.com/item?id=49584343 | Claude Opus 4.8 / 5 | Human did routing and most placement | not stated | **T** | "working prototypes" | — |
| 30 | ~15 RP2040-class designs via tscircuit, 2026-09-17 | https://news.ycombinator.com/item?id=49736506 | tscircuit, mostly OpenAI models | not stated; affiliation not stated | RP2040/RP2350/ESP32 boards | **T** | "we've ordered ~15 unique designs" | Lists AI mistakes: backwards-rotated connectors (USB port), routing loops, unreadable schematics |
| 31 | Three boards via Claude and empty KiCad files, Sep 2026 | comment on https://hackaday.com/2026/09/05/can-ai-now-design-pcbs-that-just-work/ | Claude | not stated | "moderately complex" (as stated) | **T** | "Each one has come back working first time" | Autorouting "wonky" |
| 32 | ESP32 triac mains fan controller, 2026-10-16 | https://news.ycombinator.com/item?id=50121969 | Claude Opus 5.5 | 40-year designer specified topology; bought parts; AI did schematic, parts, PCB | Mains triac + optocoupler | **T** | Boards "on their way"; pre-fabrication opinion | Unknown; a reply asks for an update |
| 33 | High-altitude balloon tracker, 4-layer, 2026-10-16 | https://news.ycombinator.com/item?id=50118893 | Claude Fable, MCP tool, ngspice | "trial and error"; reviewed | 4-layer; GPS, Pico, transmitter, IMU, flash | **T** | Not yet ordered; a simple connector board ordered | — |
| 34 | Mini Bluetooth keyboard, 15 PCBs, 2026-09-14 | https://news.ycombinator.com/item?id=49699891 | "Sol", Python generators, KiCadRoutingTools | Never read the generator code | PG1316S switches | **T** | Manufactured by JLC, not shipped | — |
| 35 | "Prompt to functioning PCB", 2026-11-20 | https://news.ycombinator.com/item?id=50571360 | Opus 5.5 with Gemini as cross-checker | not stated | not stated | **T** | "functioning PCB" | — |
| 36 | Several PCBs with Fable 5.1, 2026-10-17 | https://news.ycombinator.com/item?id=50130212 | Fable 5.1 + JLCPCB part search | not stated | not stated | **T** | "incredible", no build status | "not perfect" |
| 37 | Board designed with Codex + Sol, another with Codex + Astra, 2026-09-09 | https://news.ycombinator.com/item?id=49619821 | Codex, Sol, Astra | "mostly just need to supervise" | "more complex" (as stated) | **T** | No build status | — |

### Examined, not graded

| # | project | URL | why not graded |
|---|---|---|---|
| 38 | "Claude made this radio… but does it work?" (Adom Industries, YouTube), Nov 2026 | https://www.youtube.com/watch?v=vyClHoyzAL8 (HN https://news.ycombinator.com/item?id=50571172) | Video only; no description or write-up readable; not watched |
| 39 | EEBench "Can AI design circuit boards yet?" **[vendor: atopile]**, 2026-09-04 | https://eebench.org/blog/can-ai-design-circuit-boards-yet/ | Simulation benchmark; states V1 does not cover layout, manufacturing or bring-up |
| 40 | Diode homepage boards (Whisper SDR, Helm Jetson carrier) **[vendor]** | https://www.diode.computer/ | Photos of 10-layer boards, but the page does not say an AI designed them |
| 41 | 4-layer Linux board (SD, Ethernet, DSI) with Claude, EEVblog | https://www.eevblog.com/forum/eda/claude-code-for-pcb-design/msg6215087/ | Poster says Claude did not create the schematic or layout (BOM and checks only) |
| 42 | Phaestus (hackathon, LLM picks pre-validated blocks) | https://devpost.com/software/phaestus | HTTP 403; a search summary says a Bluetooth remote was manufactured, unverified |
| 43 | LinkedIn post: 4-layer, 135-part board, high-altitude balloon flight | https://ca.linkedin.com/in/lung-ian | HTTP 999; known only from a search-engine summary |
| 44 | Ars Technica self-setting clock, 2026-07 | https://arstechnica.com/gadgets/2026/07/i-wanted-a-clock-that-never-needed-setting-things-escalated/ | Fetch refused; an HN reply says the author used a general LLM, role unclear |
| 45 | Claude-PCB-Art (4-layer NFC art card) | https://github.com/alsunmengy/Claude-PCB-Art | Claude is the artwork's subject; README does not say an AI designed the board |

## Tally by rung

Counted from the "highest rung shown" column of rows 1–37 with:
`grep -oE '\| \*\*(T|[1-6])\*\*' B-success-claims.md | sort | uniq -c`
(row 2 duplicates row 1, so its rung is counted; row 5 is "—" and is not).

| rung | count | rows |
|---|---|---|
| 6 measured | 0 | — |
| 5 tested against function | 2 | 1, 2 (same board) |
| 4 assembled, powered | 4 | 3, 4, 6, 7 |
| 3 fabricated (bare board photo) | 1 | 14 |
| 2 DRC/ERC reported clean | 9 | 8–13, 16, 17, 19 |
| 1 render/screenshot only | 5 | 15, 18, 20, 21, 22 |
| T text only, nothing shown | 15 | 23–37 |

Distinct boards at rung 5: one (the Fable 5 e-ink watch). Of the 4 rung-4
cases, 3 are vendor content (Anthropic/Diode, Quilter, Koppar). Every rung-2
case shows no fabricated board (row 8's were in transit, the rest not
ordered or not received); 5 of those 9 are vendor
posts (4 JLCPCB, StationX) and a sixth (row 16) is a tool author's demo.
Rows graded: 2 + 4 + 1 + 9 + 5 + 15 = 36.

Pattern worth carrying to findings: the most common positive claim is a
first-hand "it works" on HN with nothing shown (15 rows), and the few
first-hand reports with detail (rows 24–26) each admit at least one fault
fixed by hand (footprint errors, a blue wire, solder fixes). Where a source
documented its own review (rows 1, 6, 9, 17), the review found board-level
faults DRC passed or did not judge: wrong packages, 35 Ω RF feed, buck far
from inductor, ERC-missed short, deleted decoupling capacitors.

## Gaps

- **No rung-6 evidence anywhere.** No source showed a scope trace, current
  draw, thermal image or EMC result for an AI-designed board. The nearest is
  Koppar's text-reported DC rail, crystal and audio-loopback figures, with its
  LTE function untested.
- **Reddit is unread.** The Fable 5 watch (rows 1–2) started on r/ClaudeAI;
  an HN reply (https://news.ycombinator.com/item?id=49584072) describes
  r/PrintedCircuitBoard posts of Claude-designed boards with 3D renders and
  ~20 unrouted connections, secondhand. Workstream R should expect many more
  rung-1 and T claims there.
- **Follow-ups not yet published.** Rows 8, 13, 14, 17, 19, 32, 33, 34 had
  boards ordered or pending on 2026-11-21; a later re-check could move them up
  or record failures.
- **Unreadable sources:** YouTube (row 38), Devpost (42), LinkedIn (43), Ars
  Technica (44), and OpenAI's Astra page (row 21 is secondhand).
- **Hackaday coverage is thin:** site search found one 2025–2026 article on
  the topic; hackaday.io project search was not done directly (web search
  returned no hackaday.io AI-designed project).
- **GitHub search is name-based.** Repos that do not say "Claude"/"AI" in
  name or description (row 7's README never mentions AI) are invisible to it.
- **Human share is self-reported** in every row; none was checked against
  commit history or file timestamps.
