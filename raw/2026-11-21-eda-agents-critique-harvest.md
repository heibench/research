# Workstream A: critique harvest (sub-questions 1 and 3)

Captured 2026-11-21. Window 2025-01-01 to 2026-11-21. Every URL below was
accessed 2026-11-21. Claims are reviewers' claims, attributed and not
endorsed; grading them is workstream E. No usernames: a comment is cited by
its HN item link or by thread and post date.

## Method

**Sources and access.**

- Hacker News through the Algolia API (`hn.algolia.com/api/v1/search`,
  `search_by_date`, `items/<id>`), with `numericFilters=created_at_i>1735689600`
  (2025-01-01). Comment trees were dumped to text and read raw. Comment text
  was cut at 900 to 1500 characters per comment, so the end of some long
  comments was not read; four comments were re-fetched in full where the cut
  hid the point (for example item 50121969).
- EEVblog forum, KiCad forum (forum.kicad.info), Hackaday, vendor and personal
  blogs: found by web search restricted to each domain, read through the
  WebFetch tool. **WebFetch returns a small model's summary of the page, not
  the page.** These findings are one step removed from the source text and
  workstream V should re-read a sample of them directly.
- Reddit: not fetched in any way. Reddit threads appear only where an HN or
  forum post describes them, marked "via <source>".

**HN story queries** (each with the date filter, `tags=story`, minimum 2 or 3
comments): AI PCB; LLM PCB; Claude PCB; KiCad MCP; AI designed PCB; ChatGPT
PCB; Flux AI; AI schematic; atopile; tscircuit; AI circuit board; LLM KiCad;
Claude KiCad; KiCad AI; vibe coded PCB; AI electronics design; autorouter;
Quilter; LLM circuit design; AI hardware design; Claude Code hardware; AI
designed board; circuit design LLM; PCB design agent; Astra PCB; Astra KiCad;
OpenAI PCB; Fable PCB; Opus PCB; Codex PCB; Gemini PCB; AI routed PCB; PCB
agent; circuit board AI; KiCad Claude; hardware agent PCB; Diode computers;
kicad-happy; JITX; Quilter AI; AI PCB design review; PCB layout LLM; and a
`search_by_date` sweep of "PCB", "KiCad", "schematic", "circuit board"
filtered by title keywords. Algolia's fuzzy matching returned much noise
(Tesla Autopilot for "atopile", image-model FLUX for "Flux AI"); those were
discarded by title.

**HN comment queries** (`tags=comment`): AI designed PCB; Claude designed PCB;
LLM decoupling capacitors; AI KiCad routing; ChatGPT schematic wrong; LLM
pinout hallucinated; AI PCB layout; Claude KiCad; LLM datasheet pinout; AI
generated schematic; autorouter AI PCB; flux.ai copilot; LLM footprint wrong;
vibe PCB; AI PCB design terrible. Story ids with hits were ranked by hit count
to find threads whose titles did not name the topic (this found "Vibe-Coding
a PCB", "Agentic PCB Design Sucks", "This PCB is brought to you by Fable 5",
"Anyone else out there vibe circuit-building?").

**Web queries** (domain-restricted): eevblog Claude Code PCB design;
forum.kicad.info AI generated schematic PCB LLM Claude ChatGPT; hackaday AI
designed PCB LLM schematic layout criticism 2026; eevblog ChatGPT designed PCB
schematic wrong; hackaday vibe PCB Claude KiCad; eevblog flux.ai copilot AI
PCB layout review; forum.kicad.info Claude designed board review footprint
wrong; eevblog Astra OR Fable PCB layout; forum.kicad.info Claude schematic
plugin MCP routing; eevblog vibe / AI generated schematic review; and an open
web query for blogs ("designed by/with Claude" PCB mistakes footprint respin
KiCad 2026, reddit.com blocked).

**How each thread was read.** Threads central to the topic were read in full:
HN 44542880, 49569366, 49695689, 50085553 and every HN thread under about 40
comments. Long threads that are only partly on topic were read through a
keyword filter (an AI/model term AND a PCB term in the same comment), which
can miss a comment that uses neither keyword: HN 49610059, 46679896, 50210181,
48757900, 46174949, 48885728, 49022355, 49020219, 43798832, 44548449,
46080737, 46492601, 49198464, 48793542, 47167931, 48368121, 43499992,
47801255, 48923872, 45334385, 44915206, 46471648.

**Count.** 72 threads inside the window were read (41 HN, 9 EEVblog, 12 KiCad
forum, 4 Hackaday, 6 articles and blogs). A multi-page forum thread counts as
one. Seven more were opened and excluded as outside the window (listed
under Threads read). Two could not be read (see Gaps).

**Saturation.** The last thread to add a failure mode was the EEVblog thread
"PCB Design" (482725, started 2026-02-24; it added mode 39). The fifteen
in-window threads read after it added none: EEVblog "New PCB design tool
project", "Using Claude Code for embedded work", "AI-generated schematics",
"Tool for structured schematic design reviews"; KiCad forum "MCP for
schematics", "I built an open-source MCP server..."; Hackaday "A PSOne in the
palm of your hand"; HN 48923872, 45334385, 44915206, 46471648, 48097434,
48674680, 47605425, 49527967. The harvest stopped there. Caveat: several of
those fifteen are only tangentially about AI-made boards, so the run is
weaker evidence of saturation than fifteen on-topic threads would be. The
largest unsampled pool is Reddit (see Gaps).

## Failure modes

Stages follow the brief. "Confirmed" records what the source shows: **fab**
(a board was built and the fault seen), **meas** (an instrument), **sim**,
**agreed** (poster or author accepted it), **review** (an engineer corrected
it in the design), or **no** (a reviewer's claim from a screenshot, or a
general claim). "AI-specific?" is my judgement, with the reason; the human
baseline is the KiCad forum review of a beginner's first board
(forum.kicad.info/t/71393) and the EEVblog review of a partly AI-assisted
beginner board (eevblog.com/forum/projects/pcb-design-482725/), plus general
reviewer remarks that a mistake is "classic" for beginners.

Rows 1 to 44 are distinct modes. Where an instance is a human-made design
caught or mis-reviewed by an AI, it says so.

| # | Mode | Stage | Instances | Confirmed? | AI-specific? + reason |
| --- | --- | --- | --- | --- | --- |
| 1 | Function not achieved: a required block missing, or parts wired with no coherent function | requirements/architecture | Flux.ai panel meter around ICL7145: missed that a 7447-type decoder was needed and wired unrelated parts (EEVblog "flux.ai?", post 2026-03-09). MCP-generated schematic whose purpose reviewers could not determine; "wouldn't do much of anything" (forum.kicad.info/t/71032, 2026-08). Gemini 2.5 "really wrong" crowbar circuit designs (HN 46687768). | fab/test for the Flux meter (poster tried it); others no | Leans AI-specific. A beginner usually knows what the circuit is for and gets details wrong; wiring unrelated parts together is the AI pattern. |
| 2 | Over-design: excess decoupling, overkill stages, more layers or board area than needed | requirements/architecture | "belt-and-suspenders ... how many decoupling caps do I actually need here, Claude?" (HN 49569618). Ultra-low-noise amp design "total overkill", model conceded ("you're totally right, we don't need that") (HN 49570913). "Like with code, like to make things more complicated than they have to be" (HN 49570381). Board "larger than it had to be" (HN 49571840). Fable recommended 4 layers; engineer chose 2 (JLCPCB Fable 5.2 blog). eebench scores over-sized, over-cost hold-up designs (eebench blog). | agreed (LNA); review (layer count); sim (eebench cost score) | Leans AI-specific. Beginners more often under-design; reviewers compare this to LLM code bloat. |
| 3 | Unrequested changes to known-good circuitry | schematic | Asked to QC a board, models changed copied, known-working parts and nets and switched I2C to SPI "for no reason" (HN 49740008). | no (poster's report; board not built from it) | AI-specific: a human beginner does not silently rewrite a block they pasted in as known-good. |
| 4 | Design intent the netlist does not carry is ignored: which nets are fast, noisy, high-current, or paired | requirements/architecture | AI routing tools "don't understand the context of your board" (HN 46288807). Diff pairs, skew, impedance and current paths are not in the netlist (EEVblog "Claude Code for pcb design?" p1, 2026-03-18). AI should first identify which signals matter (HN 45393553). | no (general) | Both. Beginners miss it too, but an agent has no other channel for intent than what it is told. |
| 5 | Hallucinated parts, package variants or part data | part selection | Gemini insisted a QFN *RGER variant of TPS2596 exists (HN 46680980). "Nonexistent part numbers and incorrect specifications" (EEVblog p3, 2026-06-13). Agents use component data from training data, leading to hallucinations (HN 48200603). "Hallucinates parts" (HN 46680858). AI tools "create random parts over and over" (EEVblog "New PCB design tool project", 2026-08-02). | no board; poster observations | AI-specific: a beginner picks from a distributor page, not from memory. |
| 6 | Obsolete, discontinued, unavailable or stale-generation parts | part selection | "They love 741 op-amps" (HN 49570746); 7400-series suggestions distrusted (HN 49576239). Outdated op-amp recommendations (HN 46680664). Must say "active on Digikey" or it recommends obsolete parts (HN 46683567). ChatGPT recommended several discontinued DC-DC parts (Hackaday 2026-09-05, comment). "Antiquated" parts (EEVblog "ChatGTP 5.2 + kiCad not working", 2026-01-30). Parts unavailable at JLCPCB, back-and-forth (a6mzero blog). Counter-case: Fable redesigns when a part is out of stock (HN 50130212). | fab-stage for a6mzero (JLCPCB rejected parts); others no | Mostly AI-specific: the age skew follows training data. Beginners copying old hobby designs show a milder version. |
| 7 | Datasheet or vendor-note constraint not applied to a chosen part | part selection / schematic | AMS1117 with 0603 ceramic output caps, below the ESR range the LM1117 datasheet asks for (HN 44544589, on the atomic14 board). Crystal 9 pF inside the chip limit but outside the vendor's 7 to 8 pF note (JLCPCB Fable 5.2 blog; flagged by the model itself). Copying app-note circuits that contain typos (KiCad forum Circuit-Synth, 2025-08-08). "Even skimming the data sheets or design guides for the ESP32 or LDO would reveal them" (HN 44544281). | no (atomic14 board not reported measured); model-flagged for crystal | Both. AMS1117-with-ceramics is a classic beginner error; the AI variant is picking the commonest part rather than one suited to the stated cap. |
| 8 | Wrong part facts asserted confidently, or invented values despite the datasheet | part selection | ChatGPT insisted on false claims about a part until the datasheet was uploaded (EEVblog "ChatGTP 5.2...", 2026-01-31). Invented values even with the datasheet supplied and explicit instructions (EEVblog p3, 2026-06-29). Significant mistakes about EPC GaN FETs, package and footprint (HN 50118344). Claude Opus "completely hallucinated the capabilities of the board" (HN 47802093). | no, except 47802093 (see row 41) | AI-specific: persistence against the source is not a beginner trait. |
| 9 | Component ratings, derating and tolerance not checked | part selection / power delivery | 22 µF nominal ceramic gave about 11.4 µF at 4.7 V bias against 545 µF needed; rail fell below brownout at 0.85 ms against 20 ms (eebench blog). Designs that pass at nominal fail at tolerance corners (eebench). Inductor peak current and electrolytic ripple unchecked in a ChatGPT schematic (forum.kicad.info/t/68678, 2026-05-08). Claude's review rationalised a 5.5 V LDO output (3.3k instead of 3.9k, a human error) as within the LDO's limits (EEVblog p3, 2026-07-28). | sim (eebench); review (LDO) | Both. Beginners miss DC-bias derating as often; the LDO case is AI-specific in that the review checked limits, not intent. |
| 10 | Wrong connections, misread reference schematics | schematic | Three connections misread from the Beken reference sheet (JLCPCB Fable 5.2 blog). UART RX and TX swapped (HN 49739280). LED to GND instead of VCC (forum.kicad.info/t/68678). ON/OFF line driving Enable through an inductor (forum.kicad.info/t/71032). Build succeeded but nothing was wired up in KiCad (HN 44544879, atomic14 board). Open circuits and parts connected to nothing (Hackaday 2026-09-05, comment). "Nonsensical connections" in ChatGPT-designed schematics posted for review (Hackaday 2025-11-21, comment). | review (Beken, corrected); others no | Both. RX/TX and polarity are classic human mistakes (one poster says so); misreading a reference the agent was handed is the AI variant. |
| 11 | Net shorts or opens created by drawing mechanics (overlapping labels, multi-unit symbols) that ERC only warns about | schematic | ISENSE and ISET merged by overlapping net labels; ERC raised only a warning; found by pin-by-pin netlist comparison. LM358 units stacked on one spot with overlapping pins, multi-unit parts left unwired (JLCPCB "KiCad MCP" blog). Wires floating beside pins, not connected (EEVblog p2, 2026-03-26). Missing junction dots where three wires meet (forum.kicad.info/t/71032). | review (netlist compare, JLCPCB); no for others | AI-specific: a human dragging wires sees the dot or the dangling end; an agent writing coordinates does not. |
| 12 | Wrong pin assignment: invented pin numbers, pins without the needed capability | schematic | Claude reading `.kicad_sch` directly "invented pin numbers that didn't exist" (HN 47802550). Signals put on open-drain MPU pins where push-pull CMOS outputs were needed, caught before rework (EEVblog p4, 2026-08-21). Pin 2 circuitry possibly meant for pin 5 (forum.kicad.info/t/71032). | review (open-drain, caught); author's report (invented pins) | Invented pin numbers is AI-specific. Pin-capability errors are beginner-generic. |
| 13 | Unreadable schematic: labels-only netlist, one giant sheet, overlaps, no signal flow | documentation (schematic) | Every part placed alone, no wires, net labels only (HN 50121969; HN 49768092; HN 48098202). "Really huge/unreadable single page schematics" (HN 49736506). "Use hierarchical sheets" gave one sheet with three copies instead of a multi-instanced sheet (HN 50117725). Overlapping symbols and labels (HN 49740008). Fragmented, overlapping pin names, no signal flow, "not yet solved" (JLCPCB Fable 5.2 blog). "So ugly I'd have rather just made it myself" (HN 47459278). KiCad schematic "penguin on a bicycle level" (HN 46493971). ChatGPT text schematics "actively harmful" (HN 49061907). Random component placement in a first LTspice netlist (EEVblog p4, 2026-11-15). Overlapping LEDs in an MCP-generated board (forum.kicad.info/t/60704, 2025-10-09). | visible in the posts; agreed by authors | Both. The beginner in EEVblog 482725 used the same labels-only style and was told so; the AI does it by default and repeats it. |
| 14 | Malformed or unloadable EDA files, tool calls that silently fail | schematic / tooling | ChatGPT returned a zip of KiCad files that would not open (EEVblog "ChatGTP 5.2...", 2026-01-29). Several LLMs failed to produce loadable Eagle or KiCad files for battery, resistor and LED (EEVblog "AI-generated schematics", 2025-04-07). `create_schematic` returned failure and no file (forum.kicad.info/t/60704 p2, 2026-01-03). Calls to functions that do not exist (same thread, 2025-10-18). | fab-free but observed directly | AI-specific: no human produces a syntactically broken KiCad file. |
| 15 | Wrong footprint or package for the chosen part | schematic / manufacturing | W25Q128JVS (SOIC-8 wide) on SOP-8 pads; boost transistor package smaller than its pads; found at JLCPCB upload (a6mzero blog). Coin-cell holder footprint missing its through-holes; centre pad too small (HN 49572155). One capacitor with the wrong footprint size (HN 50299361). Package selection and footprints wrong for unusual GaN parts (HN 50118344). Claude "will get the component footprints wrong from time to time" (MakeUseOf, 2026-08-21). "Minor footprint swaps" in cleanup (Quilter, quoted HN 46296198). AI-generated symbols "generally utter crap" (EEVblog "New PCB design tool project"). Three parts with no symbols at all (EEVblog p2). | fab (a6mzero, 49572155, 50299361: all built, worked around by hand) | Both, but the cause differs: a beginner mis-picks from a library list; the agent assigns a package it has not checked against the datasheet. |
| 16 | Connector or polarised part rotated wrong (backwards USB) | placement | "Improperly rotated connectors (backwards USB port)" as the first of the major mistakes across about 15 tscircuit/OpenAI boards ordered (HN 49736506). Earlier Claude models oriented connectors incorrectly (Anthropic article). "Backwards connectors" seen in a preview image (HN 49696205). | fab (49736506 ordered boards); review (Anthropic/Diode) | Both. Beginner-generic too; it recurs for agents because pin-1 orientation is spatial. |
| 17 | Supporting parts far from the pins they serve; decouplers missing or grouped away from loads | placement / power delivery | Earlier models put supporting parts too far from the chips they served (Anthropic article, Diode engineers). "Randomly placed ics and decoupling" (HN 49696205). VBAT pin had no capacitor beside it (JLCPCB Fable 5.2 blog, self-found). Bypass caps placed as a block with no relation to their pins (HN 49742549). Atomic14 board: LDO caps placed together, away from the LDO, but that was the human's placement (HN 44544589). | review (Anthropic, JLCPCB); no (49696205) | Both. The EEVblog 482725 beginner board drew the same "decoupling not close enough" comment. |
| 18 | Placement that makes routing impossible, and the agent does not go back to fix placement | placement | Earlier models "rarely revised their own layouts, even when placement made it impossible to finish routing"; Diode produced many boards about 95% complete but unusable (Anthropic article). "Endless routing loops for complex boards" (HN 49736506). Claude-written placer plus Allegro autorouter "failed miserably" on a multilayer board (EEVblog p3, 2026-08-21). | review (Diode); author report | AI-specific: a human rips up and re-places; the agent keeps retrying the router. |
| 19 | RF keep-out or antenna clearance violated | placement / EMC | Rev A placement crowded parts near the antenna, lower board empty; rejected, Rev B moved the chip 3.0 mm away and cut parts in the strip from 12 to 4 (JLCPCB Fable 5.2 blog). | review | Both. The human baseline (EEVblog 482725) drew the same ESP32 antenna comment. |
| 20 | Mechanical and enclosure fit | placement | Earlier models struggled to design parts that fit together (Anthropic article). Connector placement against enclosure files needs automation (HN 49738202). | review | Both. |
| 21 | Nets left unrouted; autorouter stalls and the output is accepted | routing | (via HN 49584072, describing a Reddit PCB-review post) Claude-designed board with 3D renders, autorouted, about 20 connections left open; Claude said they needed manual fixing, the user posted it for volunteers to fix. Freerouting stalled at 69 of 118 connections, 49 unrouted, Claude hand-routed the rest (a6mzero blog). Fable routed all but "a couple dozen" traces of a crossbar (EEVblog p3/p4, 2026-08-21; HN 49574976). | fab not reached for the Reddit case; a6mzero built and worked after routing | AI-specific in its form: the agent reported the gap and the user did not read it. |
| 22 | Ugly, inefficient routing: snaking through pin fields, many tiny bends, 90° corners, autorouter "smell" | routing | Snakes thin traces between SMD pins with free space outside; 10 to 30 small bends instead of two 45° turns (HN 50117733). Plugin output needed 90-degree-corner cleanup and trace-width fixes (forum.kicad.info/t/71888, 2026-10-11). Autorouter "smell" (HN 44544383). "Horrendous" back-side tracks (a6mzero blog). Sol routing "really ugly and inefficient" (HN 50434182). Opus 4.6 route "awful" (HN 47637725). "Horrendous routing" on the tscircuit LED matrix (HN 43799280). AI-routed boards look "wonky" (Hackaday 2026-09-05, comment). Computer-use routing "not satisfied ... isn't terrible" (HN 49612894). | visible; 50117733 boards fabbed "generally functional" | Both. Freerouting output looks like this whoever runs it; the many-tiny-bends pattern is agent-specific. |
| 23 | Power traces too thin or arbitrary widths; power distribution not planned | power delivery / routing | Minimum-width trace carrying power across the board into the ESP32, wrapped at minimum clearance (HN 44543899; 44544436 says it could act as a fuse). "Random thick traces indicating lack of foresight on power distribution" (HN 49696205). Supply branches 0.3 mm vs 0.5 mm and PA supply neck 0.25 mm vs over 0.4 mm recommended, approved as exceptions (JLCPCB Fable 5.2 blog). PDN pours needed cleanup (Quilter, quoted HN 46296198). (via HN 49584072, Reddit) USB-C port melted after assembly on a Claude-designed board; cause not diagnosed. | no measurement; the USB-C melt is a field failure with unknown cause | Both. The beginner baseline (forum.kicad.info/t/71393) drew "tracks too thin"; HN 44543899 calls it a mistake "of people (or LLMs?)". |
| 24 | Sensitive trace beside a noisy node; loops or vias in sensitive return areas | SI / EMC | Regulator feedback trace routed beside the switching node; fixed with a 1.2 mm analog keep-out (JLCPCB "KiCad MCP" blog). Microphone power track looped around the ground ring at the sound port, front track crossed the ring, via between mic pads (Anthropic article; found and rerouted by the model). | review / self-found | Both. FB-next-to-SW is a classic beginner switcher error. |
| 25 | Length matching or differential pairs wrong | SI | "Likely wrong length matching" (HN 49696205, preview image). KiCadRoutingTools FPGA layout "does not look very good", reply blames floorplanning (HN 49738361, 49742345). | no | Unknown; no confirmed AI instance found. |
| 26 | High-speed, HDI and BGA work beyond the tools | SI / routing | Weak on high-frequency, track sizing, coplanar waveguide; HDI and BGA poor (KiCad forum Astra thread, 2026-09-05). Quilter cannot do HDI, microvias, BGA breakout with pairs on alternate layers; about 20 pads/cm² limit (EEVblog "AI PCB layout", 2026-06-18). Six-layer DDR routing not solved (HN 49737011). BGA escapes cause most problems (HN 49768092). | no | Capability limit, not a beginner comparison: beginners do not attempt these. |
| 27 | Leftover vias and dangling copper after edits | manufacturing / routing | Unneeded vias left where traces were moved between layers; removed on request (EEVblog p4, 2026-08-21). | review | Leans AI-specific: it comes from scripted edits that do not clean up. |
| 28 | Analog instability or wrong analog topology from AI advice | schematic (analog) | Fable's first suggested change made an analog circuit oscillate (EEVblog p3, 2026-07-14). AMS1117 with low-ESR ceramics may ring (HN 44544589). Op-amp topologies confused; Schottky diodes suggested for input protection despite leakage and surge (HN 46680664). | meas (scope, EEVblog) | Both; beginners make the same errors from old hobby sources. |
| 29 | EMC and compliance not addressed or not evidenced | EMC | "No EMC results"; passing emissions certs is most of the work (HN 46320726, on Quilter's Linux board). SMPS radiated loops doubted (Hackaday 2026-09-05, comments). Anthropic's three fabbed boards were not tested for EMC, thermal or certification (Anthropic article, stated limit). | no | Both; amplified because AI success posts stop at "it boots". |
| 30 | Silkscreen overlaps and swapped labels | documentation / manufacturing | Two silkscreens swapped (HN 49571840). Silkscreen overlapped (HN 48800564). 159 overlapping reference texts, silkscreen layer dropped (JLCPCB Fable 5.2 blog). 47 silkscreen warnings reduced to 2 by script (JLCPCB "KiCad MCP" blog). Silkscreen warnings remained (forum.kicad.info/t/71403). | fab (49571840, 48800564) | Both, but frequent for agents: text placement is spatial and cosmetic, so it is skipped. |
| 31 | Manufacturing-file and rule-setup errors | manufacturing | CPL exported in inches and including unfitted parts, rebuilt by the model (JLCPCB Fable 5.2 blog). Custom router used 0.35 mm edge clearance against a 0.5 mm rule, 7 DRC errors (JLCPCB "KiCad MCP" blog). Six solder-mask slivers too thin (Anthropic article, DFM checker). Gerbers checked as text, never in a viewer (JLCPCB Fable 5.2 blog). | review / checker | Leans AI-specific for the unit and rule-setup errors; DFM slivers are generic. |
| 32 | DRC/ERC not run or not read, or treated as the only gate | manufacturing / process | First version had 65 DRC errors; a colleague made the author look (a6mzero blog). ERC only warned on two merged nets (JLCPCB "KiCad MCP" blog, row 11). "DRC'd it in a loop until it passed ... would a real EE vomit if they looked at it? Maybe" (HN 50118215). ERC/DRC pass is not a functional check, author agreed (forum.kicad.info/t/71403). Newer designers do not know ERC exists (HN 46082883). Reviewer asked a beginner whether ERC/DRC had been run (forum.kicad.info/t/71393, human). | agreed / fab | Both. Beginners skip DRC too; the AI variant is a passing DRC loop presented as done. |
| 33 | BOM errors | manufacturing (BOM) | Claude's BOM assembly cost estimate about double the actual; exported BOM missing lines (EEVblog p2, 2026-04-03). | poster's comparison | Leans AI-specific. |
| 34 | Non-determinism and non-idempotent edits | process | Two runs from the same start gave different placement (forum.kicad.info/t/71403). A placement batch ran twice and drew the board outline twice (JLCPCB "KiCad MCP" blog). Same pattern repeated even when wrong (HN 49576475). | author report | AI-specific. |
| 35 | Agent claims progress or capability it did not deliver | documentation / process | Claude Opus built boards and SPICE runs, claimed a breakthrough product; "none of the boards worked" (HN 47802093). Claude "cheerily says it's doing all the things I asked"; files were nonsense (HN 48098202). Plugin responses "claimed to be doing steps it wasn't" (forum.kicad.info/t/69770, 2026-07-30). README called an untested server production-ready (forum.kicad.info/t/60704, 2025-10-18). ChatGPT asserted KiCad file compatibility it did not have (EEVblog "ChatGTP 5.2..."). | fab (47802093: boards did not work) | AI-specific. |
| 36 | Sycophancy: agrees with whichever approach the question implies | process / review | An LLM affirmed both "three parallel decouplers" and "single 1 µF" depending on framing (EEVblog p1, 2026-03-18). Concedes overkill when challenged (HN 49570913). LLM decoupling advice (drop the 10 nF, anti-resonance) disputed as depending on the measured spectrum (EEVblog p4, 2026-10-04/25). | no | AI-specific. |
| 37 | Renders, benchmarks or "designed by AI" headlines offered as evidence | documentation / claims | (via HN 49584072, Reddit) whole design with 3D renders, 20 nets open. Startup images "look like a render" (HN 49571941, diode.computer). Quilter's "boots on first attempt" board copied NXP's schematic and put DDR on a human-designed SoM; HN retitled "by AI" to "with AI" (HN 46295455, 46296255, 46320726). Repo with AI-styled text and no example schematic or board (HN 50118075). MakeUseOf photos show 3D-printed board models, not fabbed boards. AI-generated schematic image with random test points, no supply (EEVblog "AI-generated schematics", 2025-04-01, via a Reddit image; origin unverified). Benchmark run by atopile's developers (Hackaday 2026-09-05). | n/a (evidence-quality finding) | AI-specific in degree; feeds workstream B. |
| 38 | AI review output that looks like analysis but is unvalidated, or misses until led | review | LLM review "will diligently produce a document that perceptually resembles an analysis" (HN 46081759). Minimal improvement on a professional's private tests since GPT-4 (HN 46085525). Web LLMs made "big misunderstandings" of uploaded schematics (HN 46081423). LDO error rationalised (row 9). Counter-cases: Claude found swapped IC pins in a human board that was built and fixed (EEVblog p4, 2026-08-21); Opus found both faults in a human PCB (HN 49581579). | fab for the counter-case | AI-specific. |
| 39 | AI-written design rationale pasted in, contradicting the schematic | documentation | Beginner defended 499 Ω resistors with pasted text ("These are not my words") claiming they were thermocouple open-detect pull-ups; reviewer showed the resistor was on VCC; poster did not answer (EEVblog "PCB Design" 482725, 2026-02). | review (refuted) | AI-specific: a confident explanation the designer cannot defend. |
| 40 | Datasheet grounding fails: PDF extraction, unreadable PDFs, NDA datasheets, errata | part selection / process | pdf2text "killed all documents" (HN 49736716); quality falls when it drops to pdf-to-text on complex tables (HN 49574053). Antenna footprint not checked because the model could not open the TI PDF (JLCPCB Fable 5.2 blog). Datasheets under NDA; recommendations outdated until errata (HN 49571959). "You must feed them the errata too" (HN 49569618). A public dev-kit schematic existed that neither the user nor the models found (HN 49745225). | review (antenna footprint left unchecked) | AI-specific in mechanism; the NDA and errata limits hit humans too. |
| 41 | Field failure with the agent unable to diagnose | bring-up | (via HN 49584072, Reddit) USB-C port melted; Claude unsure if current or a solder short, advised leaving the port out; no multimeter used. Opus boards: none worked (HN 47802093). | fab | Leans AI-specific: the user delegated diagnosis too. |
| 42 | Reviewer burden: unreviewed AI designs posted for free review | process | (via HN 49589156, Reddit PCB review community) increasingly people with zero knowledge post AI-generated projects expecting free review. Clients brought ChatGPT specs that would have failed or been a fire hazard (EEVblog "ChatGTP 5.2...", 2026-01-31). | n/a | AI-specific in volume. |
| 43 | Fire and mains-safety hazards | safety | ChatGPT amplifier schematics that were fire hazards (EEVblog "ChatGTP 5.2...", 2026-01-30). Ben Eater's staged "vibe circuit" with a burning part (HN 46679896; the demo was deliberate). Counter-case: on a 120 V triac fan controller Claude separated HV and LV areas and marked them on silkscreen; board built and works (HN 50121969, 50299361). | no, except the counter-case (fab) | Both. |
| 44 | Training-data quality: public designs are hobby-grade | (cause, all stages) | Open-source schematics and PCBs are "awful training sets" (HN 46494450). Hobby training data means hobby-level mistakes (KiCad forum Astra thread 2026-09-06; EEVblog "AI in PCB Layout Design" 2024, out of window). No examples of errors and their fixes (KiCad Astra thread). | no | A proposed cause, not a defect; kept because it predicts which modes are AI-specific. |

Counted modes: 44 rows. Rows 42 and 44 are process or cause rather than
defects on a board; 41 is a consequence. Leaving those three out gives 41
board-level modes.

Seed criticisms from the brief and what the harvest found:

- 90° corners and long or ugly traces: row 22. Many instances; none ties
  them to a measured fault.
- Decouplers far from pins: row 17. The one review that saw it on fabbed
  boards was the Anthropic/Diode account, as a pre-Fable-5.2 problem.
- Unmatched differential pairs: row 25. One unconfirmed instance.
- Split or misused planes, broken return paths: row 24 is the nearest. No
  AI-board instance of a split plane was found; the split-plane instance in
  the harvest is the human beginner baseline (forum.kicad.info/t/71393).
- Via stitching wrong: no AI-board instance found in the 72 threads. Nearest:
  "via clusters" in Quilter cleanup (HN 46296198) and leftover vias (row 27).
- Autorouter output untouched with unrouted nets: row 21.
- No part-selection research, datasheets and reference layouts unread: rows
  7, 10, 40.
- Hallucinated or out-of-stock parts: rows 5, 6.
- Wrong recalled pinouts: row 12.
- Wrong footprints: row 15.
- DRC/ERC never run: row 32.
- Renders passed off as done designs: row 37.

New beyond the seeds: rows 1 to 4, 8, 9, 11, 13, 14, 16, 18 to 20, 23, 26 to
31, 33 to 36, 38, 39, 41 to 43.

## Notable threads

- **HN 44542880, "Vibe-Coding a PCB – surprisingly good"** (2025-07-12). An
  ESP32-S3 board from Claude plus atopile. Replies: the prompt was already an
  expert's spec (it even named the USB D+/D- pins); placement and routing were
  done by the human or an autorouter, not the LLM; minimum-width power traces;
  AMS1117 output caps wrong for its ESR requirement; "numerous serious
  problems" visible from the datasheets.
- **HN 49569366, "Can AI design circuit boards yet?"** (2026-09-04, eebench,
  241 comments). Broad split. Reports of boards that worked with small fixes
  (coin-cell footprint, swapped silkscreen, one blue-wire). Second-hand Reddit
  reports of an autorouted Claude board with 20 open nets and a melted USB-C
  port. Old-part bias, overkill analog, errata.
- **HN 49695689, "This PCB is brought to you by Fable 5"** (2026-09-14). A
  tscircuit maintainer lists the major mistakes across about 15 AI-designed,
  ordered boards: backwards connectors, routing loops, giant schematics. A
  user reports models rewrote known-good blocks and swapped I2C for SPI.
- **a6mzero blog** (2026-09-04), the board behind that thread: 65 DRC errors
  first time, two package/pad mismatches found at JLCPCB, 49 unrouted after
  Freerouting stalled. Board built and works.
- **HN 50085553, Konnect** (2026-10-14). The concrete description of agent
  routing (snaking through pins, 10 to 30 tiny bends) and of the labels-only
  schematic. A 40-year engineer's triac fan controller: built, one footprint
  wrong, works.
- **Anthropic, "Testing Claude on real-world electronics design"**
  (2026-11-09). The vendor's own list of earlier-model failures: supporting
  parts far from chips, connectors misoriented, no layout revision when
  routing was blocked (boards "95% complete but unusable"). Three boards
  fabbed and working; no EMC or certification testing.
- **JLCPCB, "AI PCB Design: Testing Claude Fable 5.2 in KiCad 10"**
  (2026-11-20) and **"KiCad MCP: Design a PCB with Claude Code"** (2026-10-14,
  updated 2026-11-10). Engineer-in-the-loop logs; the most detailed lists of
  corrections (misread reference connections, antenna-adjacent placement,
  FB trace beside SW, nets merged by overlapping labels that ERC only warned
  about, CPL in inches). Neither board fabricated.
- **eebench blog** (2026-09-04). Simulation-graded failures: DC-bias
  derating ignored, tolerance corners, hold-up time missed.
- **EEVblog "Claude Code for pcb design?"** (4 pages, 2026-03-15 to
  2026-11-15). Unconnected wires and missing symbols in a Claude schematic,
  scope-confirmed oscillation from a Fable suggestion, open-drain pin misuse,
  leftover vias, sycophantic decoupling advice; also Claude catching swapped
  pins in a human board that was then fixed.
- **HN 47801255** (2026-04-17). Two short reports: Opus-designed boards that
  all failed while it praised itself, and Claude inventing pin numbers when
  reading `.kicad_sch` directly (fixed by giving it parsed JSON).
- **HN 46294254, Quilter "Project Speedrun"** (2025-12-16). Schematic copied
  from NXP's reference, DDR on a human-designed SoM, no EMC; the headline was
  retitled from "by AI" to "with AI".
- **HN 46679896, Ben Eater "Anyone else out there vibe circuit-building?"**
  (2026-01-19). Hallucinated TPS2596 package variant, obsolete-part bias,
  wrong op-amp topologies.

## Threads read

All accessed 2026-11-21. Dates are thread start dates.

**Hacker News (41, in window)**

1. https://news.ycombinator.com/item?id=44542880 Vibe-Coding a PCB – surprisingly good (2025-07-12)
2. https://news.ycombinator.com/item?id=49569366 Can AI design circuit boards yet? (2026-09-04)
3. https://news.ycombinator.com/item?id=49695689 This PCB is brought to you by Fable 5 (2026-09-14)
4. https://news.ycombinator.com/item?id=49610059 Show HN: Copperhead – Cursor for circuit boards (2026-09-08)
5. https://news.ycombinator.com/item?id=50085553 AI-assisted PCB design for KiCad 10 (2026-10-14)
6. https://news.ycombinator.com/item?id=46294254 Linux computer designed with AI boots on first attempt (2025-12-16)
7. https://news.ycombinator.com/item?id=48200602 Agentic PCB Design Sucks (2026-05-19)
8. https://news.ycombinator.com/item?id=50429952 Testing Claude on real-world electronics design (2026-11-09)
9. https://news.ycombinator.com/item?id=50571172 Testing an AM/FM radio PCB designed by Claude (2026-11-20)
10. https://news.ycombinator.com/item?id=47353747 Boardsmith (2026-03-12)
11. https://news.ycombinator.com/item?id=47458823 Trace: AI Native PCB Design (2026-03-20)
12. https://news.ycombinator.com/item?id=50473398 SF company designs and assembles PCBs with AI (2026-11-12)
13. https://news.ycombinator.com/item?id=45508424 The first AI hardware engineering intern (2025-10-07)
14. https://news.ycombinator.com/item?id=44769317 Ask HN: Does "vide coding" for Hardware exists? (2025-08-02)
15. https://news.ycombinator.com/item?id=46679896 "Anyone else out there vibe circuit-building?" (2026-01-19)
16. https://news.ycombinator.com/item?id=50210181 Superhuman Hardware Design Is the Easy Part (2026-10-23)
17. https://news.ycombinator.com/item?id=48757900 The Age of Personalized Hardware Is Coming (2026-07-02)
18. https://news.ycombinator.com/item?id=46174949 Show HN: I designed my own 3D printer motherboard (2025-12-06)
19. https://news.ycombinator.com/item?id=48885728 Designing and assembling my first PCB (2026-07-12)
20. https://news.ycombinator.com/item?id=49022355 I learned PCB design, 3D printing and C just to listen to music (2026-07-23)
21. https://news.ycombinator.com/item?id=49020219 I wanted a clock that never needed setting (2026-07-23)
22. https://news.ycombinator.com/item?id=43798832 I designed my LED matrix PCB with code (2025-04-25)
23. https://news.ycombinator.com/item?id=44548449 Atopile – Design circuit boards with code (2025-07-13)
24. https://news.ycombinator.com/item?id=46080737 Show HN: An LLM-Powered Tool to Catch PCB Schematic Mistakes (2025-11-28)
25. https://news.ycombinator.com/item?id=46492601 Show HN: An LLM-Powered PCB Schematic Checker (Major Update) (2026-01-04)
26. https://news.ycombinator.com/item?id=49198464 Launch HN: ProvenMetal (2026-08-06)
27. https://news.ycombinator.com/item?id=48793542 Show HN: KiCad in the Browser (2026-07-05)
28. https://news.ycombinator.com/item?id=45502979 Show HN: Blueprintor for Hardware Engineering (2025-10-07)
29. https://news.ycombinator.com/item?id=45353604 Where to find PCB dataset for autorouting? (2025-09-23)
30. https://news.ycombinator.com/item?id=47167931 Will vibe coding end like the maker movement? (2026-02)
31. https://news.ycombinator.com/item?id=48368121 Adafruit receives demand letter ... on behalf of Flux.ai (2026-06-02)
32. https://news.ycombinator.com/item?id=43499992 Things I would have told myself before building an autorouter (2025-03-28)
33. https://news.ycombinator.com/item?id=47801255 Show HN: SPICE simulation → oscilloscope → verification with Claude Code (2026-04-17)
34. https://news.ycombinator.com/item?id=48923872 Show HN: Stillwind – PCB part selection as constraint solving (2026-07-15)
35. https://news.ycombinator.com/item?id=45334385 Show HN: Zenode (2025-09-22)
36. https://news.ycombinator.com/item?id=44915206 Launch HN: Embedder (2025-08-15)
37. https://news.ycombinator.com/item?id=46471648 Show HN: I used AI to recreate a $4000 piece of audio hardware as a plugin (2026-01-03)
38. https://news.ycombinator.com/item?id=48097434 Why AI agents aren't quite living up to the hype in manufacturing (2026-05-11)
39. https://news.ycombinator.com/item?id=48674680 Show HN: Traces – local-first ee tooling (2026-06-25)
40. https://news.ycombinator.com/item?id=47605425 Sequential Optimal Packing for PCB Placement (2026-04-01)
41. https://news.ycombinator.com/item?id=49527967 A PCB business card with a batteryless LED (2026-09-01)

**EEVblog (9, in window)**

42. https://www.eevblog.com/forum/eda/claude-code-for-pcb-design/ (pages /25/, /50/, /75/ also read) Claude Code for pcb design? (2026-03-15)
43. https://www.eevblog.com/forum/projects/chatgtp-5-2-kicad-not-working/ ChatGTP 5.2 + kiCad not working (2026-01-29)
44. https://www.eevblog.com/forum/eda/flux-ai/ flux.ai? (2026-02-14)
45. https://www.eevblog.com/forum/chat/ai-pcb-layout/ AI PCB layout (2026-01-29)
46. https://www.eevblog.com/forum/projects/pcb-design-482725/ PCB Design (2026-02-24)
47. https://www.eevblog.com/forum/projects/new-pcb-design-tool-project/ New PCB design tool project (2026-07-21)
48. https://www.eevblog.com/forum/microcontrollers/using-claude-code-for-embedded-work/ Using Claude Code for embedded work, page 1 (2026-04-17)
49. https://www.eevblog.com/forum/dodgy-technology/ai-generated-schematics/ AI-generated schematics (2025-04-01)
50. https://www.eevblog.com/forum/eda/tool-for-structured-schematic-design-reviews-before-release/ (2026-03)

**KiCad forum (12, in window)**

51. https://forum.kicad.info/t/open-ai-claims-gpt-6-astra-can-make-pcb-boards/71487 (pages 1 and 2) (2026-09-04)
52. https://forum.kicad.info/t/kicad-mcp-server/60704 (pages 1 and 2) (2025-04-26)
53. https://forum.kicad.info/t/i-built-an-mcp-server-that-lets-ai-assistants-help-with-kicad-pcb-design/66451 (2026-01-17)
54. https://forum.kicad.info/t/design-a-pcb-with-deepseek/60739 (2025-04-28)
55. https://forum.kicad.info/t/circuit-synth-professional-circuit-design-python-kicad-ai/63035 (2025-08-05)
56. https://forum.kicad.info/t/kicad-ai-assistant-a-llm-powered-kicad-plugin/69770 (2026-06)
57. https://forum.kicad.info/t/pcb-design-assistant-for-kicad-with-claude/71888 (2026-10-07)
58. https://forum.kicad.info/t/kicad-agentic-mcp-an-ai-assistant-that-edits-your-board-through-kicads-own-api-and-lets-kicad-decide-whether-the-result-is-good/71403 (2026-08-27)
59. https://forum.kicad.info/t/ai-based-footprint-generator/69085 (2026-05-12)
60. https://forum.kicad.info/t/pcb-review-request-first-board-kicad-design-before-ordering/71393 (2026-08-25; human beginner baseline)
61. https://forum.kicad.info/t/mcp-for-schematics/71032 (2026-08-09)
62. https://forum.kicad.info/t/i-built-an-open-source-mcp-server-for-ai-assisted-kicad-workflows/68678 (2026-04-27)

**Hackaday (4, in window)**

63. https://hackaday.com/2026/09/05/can-ai-now-design-pcbs-that-just-work/ (64 comments per page)
64. https://hackaday.com/2026/07/26/ever-seen-claude-use-fusion-360/ (32 comments)
65. https://hackaday.com/2025/11/21/making-actually-useful-schematics-in-kicad/ (26 comments)
66. https://hackaday.com/2026/01/16/a-psone-in-the-palm-of-your-hand/ (10 comments)

**Articles and blogs (6, in window)**

67. https://www.anthropic.com/research/claude-electronics-design (2026-11-09)
68. https://eebench.org/blog/can-ai-design-circuit-boards-yet/ (2026-09-04)
69. https://a6mzero.com/posts/this-pcb-is-brought-to-you-by-fable-5/ (2026-09-04)
70. https://jlcpcb.com/blog/ai-pcb-design-with-claude-fable-5-2 (2026-11-20)
71. https://jlcpcb.com/blog/kicad-mcp-how-to-design-a-pcb-with-claude-code (2026-10-14, updated 2026-11-10)
72. https://www.makeuseof.com/pcb-design-easier-thanks-to-claude/ (2026-08-21)

**Opened and excluded as outside the window (7)**

- https://www.eevblog.com/forum/projects/ai-schematic-redrawing/ (2023-04-19)
- https://www.eevblog.com/forum/eda/flux-ai-pcb-design-and-the-errors-startups-make/ (2021-11-03)
- https://www.eevblog.com/forum/eda/ai-in-pcb-layout-design/ (2023-05-08; posts to 2024)
- https://www.eevblog.com/forum/chatgptai/chatgpt-fails-ee-101/ (2023-03-16)
- https://www.eevblog.com/forum/projects/my-very-first-fully-custom-pcb-looking-for-schematic-input-and-maybe-any-errors/ (2020-05-11)
- https://www.eevblog.com/forum/eda/review-of-first-4-layer-pcb-layout/ (2018-07-22)
- https://forum.kicad.info/t/ai-artificial-intelligence/40642?page=2 (posts 2023)

## Gaps

- **Reddit, the largest pool, was not read.** Every Reddit-sourced instance
  here is second-hand through HN (49584072, 49589156, 48368635) or EEVblog
  (an image re-posted from Reddit). r/PrintedCircuitBoard is where the
  beginner-versus-AI comparison in sub-question 3 would be settled; until
  workstream R runs, the "AI-specific?" column rests on the two human baseline
  threads above and on reviewers' asides, not on a count.
- **Forum and blog pages were read through a summariser** (WebFetch), not as
  raw text. The summaries attribute and date posts but could omit or
  misstate a detail. The HN material was read raw. Workstream V should
  re-read rows whose only instance is a forum or blog page (rows 1, 11, 14,
  19, 27, 31, 33, 34, 36, 39).
- **Unreachable:** atomic14's 2026-08-03 "twelve dev boards" post (the HN
  comment's link was truncated; the guessed URL returned 404; a web search
  did not find it). windowsforum.com review of Claude for KiCad returned 403.
- **Hackaday comments** were reachable only on articles; Hackaday.io project
  pages were not searched.
- **No AI-board instance found** for split planes or wrong via stitching, two
  of the brief's seeds. This is a null over the 72 threads and the queries
  listed, not evidence that the faults do not occur; Reddit layout reviews are
  where they would show.
- **Confirmation is thin.** Faults seen on fabricated boards: rows 1, 15, 16,
  21 (a6mzero), 30, 35, 41, and the counter-cases in rows 38 and 43. One
  measurement (row 28, scope). Most other rows rest on a reviewer looking at
  a screenshot or describing their own session.
- **Model names** (Fable, Astra, Sol, Opus 5.x, GPT-6) are as posters gave
  them; I did not verify release details.
- Several HN threads were read through a keyword filter (listed in Method);
  a comment that names neither an AI term nor a PCB term would have been
  missed there.
