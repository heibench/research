# Bibliography: eda-agents

Each entry says what the source **established** for this topic's question,
not what it is about. All accessed **2026-11-21**. Forum and Hacker News
threads are not listed one by one; they are in the captures
(`raw/2026-11-21-eda-agents-*.md`), which carry every URL.

Claims are attributed, not endorsed. Where V (the verification pass) corrected
a capture, the entry uses the corrected value and `findings.md` says so.

---

## 1. Papers

**PCBSchemaGen** — Zou et al., arXiv 2602.00510 (v2, 17 Jun 2026).
Established: grounding an LLM in a datasheet-derived schema is the largest
single factor in passing its schematic verifier. Without grounding 26.8%,
component-only 77.6%, full schema 81.3% (62-task PCBBench). Replacing
pin-level feedback with pass/fail costs 23.6 points. The verifier is also the
reward; it agreed with blind senior-engineer labels at κ 0.91 on 300 samples.
One fabricated prototype shown, no measurements.

**Evaluating LLM workflows for SMPS design** — Nau, Krummenauer, Zimmermann,
arXiv 2507.10639 (v2, 7 Nov 2025). Established: on 269 switched-mode supply
tasks, SPICE feedback raised solve rate far more than retrieval over
datasheets (o3: 25.4% alone, 44.1% with retrieval, 84.9% with SPICE, 90.7%
with both). Oracle is LTspice; no hardware built.

**PCBWorld** — Song et al., arXiv 2607.05915 (v2, 3 Aug 2026). Established:
an LLM routing agent that sees KiCad's DRC after every step beats the same
model planning open-loop (GPT-5.4 on D3-A: 0.65 clean pass @5 interactive,
0.19 plan-and-execute, 0.02 engine-free). Freerouting alone scored 0.80 on
the same set. No fabrication.

**PCBRouteAgent** — Zhang et al., arXiv 2611.08175 (v1, 5 Nov 2026).
Established: a routing agent pairing global planning with geometric execution
and DRC feedback; quotes the GPT-5.4 agent at 42% on D3-A under its own
protocol. No fabrication. Details in capture D.

**Other papers read** (capture D, each with its "Established" line):
2606.17074 (GenAI in PCB design survey), 2606.19795 (agentic EDA handoff),
2608.31006 (LLM-driven RF workflow), 2510.17002 (EEschematic), 2603.18102
(HWE-Bench), 2603.15672 (DRCY), 2606.01188 (pcbGPT), 2610.38201, 2607.03261
(OmniLayout); venue abstracts for PCBInnoBench, EDA Bench, PCB Gym,
PCB-Bench. None fabricated and measured a board.

## 2. Tools and prior art

**mcp-server-kicad** — github.com/ProductOfAmerica/mcp-server-kicad, README
"Why maintenance mode", commit `f972bfb` (2026-10-23), re-read 2026-11-21.
Established, by its authors' own test on one unpublished design: plain Claude
Code with KiCad installed got 18 of 18 single edits right; the same model with
the 109-tool plugin got 3 of 18. In a 20-edit session both got every edit
right; the plugin used about 1.8 times the context. Causes named: missing
verbs, an instruction never to edit files directly, a sync tool that rewrote
every footprint.

**jvanderberg/kicad-skills** — `skills/kicad-pcb-workflow/scripts/refparts.py`,
commit `7837f97`. Established: a datasheet reference-parts check is
buildable: each IC's typical-application parts, with the datasheet figure
cited, checked against the design, failing MISSING, WRONG VALUE or FAR.

**florianuhlemann/claude-skills** — `pcb-audit/skill/scripts/check_decoupling.py`,
commit `ca18b42`. Established: "decoupler fed through the plane" is checkable
from the board file (walking same-net tracks from the pin must reach the
capacitor before any via); the script treats it as a blocker.

**aklofas/kicad-happy** — commit `6b9767e`. Established: its EMC rules measure
and grade but do not fail by default; only `fab_release_gate.py --strict`
fails on error-severity findings (V corrected capture C).

**The other 13 skill and MCP repositories** in capture C, each at its recorded
SHA. Established, across all 17: none shows a board fabricated and tested.

**Commercial tools** (capture D): Flux, Circuit Mind (ACE, AVE), atopile and
EEBench, tscircuit, Copperhead and copperbench, Quilter, JITX, Diode/Zener,
Cadence, Siemens, Altium. Established: none publishes measurements of a board
it designed; claims are recorded as vendor claims.

**Anthropic article on Diode's Fable boards** (cited in captures A and B).
Established, as the vendor's account: earlier models rarely revised placement
when it blocked routing, leaving boards about 95% complete; three boards were
fabricated and not tested for EMC, thermal or certification.

## 3. Design-rule sources (grading, capture E)

**TI SPRABV2**, *General hardware design / BGA PCB design / BGA decoupling*
(Feb 2019). Established: mixed decoupler values can resonate unpredictably
(§2.1); one value of 0.1–0.2 µF in the smallest package plus bulk is
recommended; the capacitor-to-via connection matters more than distance from
the pin (§3).

**TI SZZA009**, *PCB Design Guidelines for Reduced EMI* (Nov 1999).
Established: decoupler loop and placement guidance (§2.2.4); gridded ground
fill helps two-layer boards (§2.2.3); crystal placement guidance.

**TI SLYT512**, Pithadia and More, "Grounding in mixed-signal systems
demystified, Part 2" (AAJ 2Q 2013). Established: one partitioned ground plane
is preferred; split grounds are for narrow cases such as ≥20-bit delta-sigma
front ends.

**E. Bogatin, "The Case for Split Ground Planes"**, *Signal Integrity
Journal*, 21 Feb 2023 (summary read, V confirmed). Established: a split gives
little benefit and real cost when signals cross it.

**E. Bogatin, "Should You Worry About 90-Degree Bends in Circuit Board
Traces?"**, *Signal Integrity Journal*, 13 Apr 2021 (summary read, V
confirmed). Established: a 20 mil trace's corner is transparent below about
25 GHz; a 120 mil one matters near 5 GHz.

**TI SPRAAR7**, *High-Speed Interface Layout Guidelines* (rev. Feb 2023).
Established: per-interface pair limits (USB HS), reference-plane continuity
(§2.4), via stubs on multi-Gb/s nets (§3.6).

**TI SLYT614** (Glaser, AAJ 1Q 2015) and **SNVA021** (AN-1149). Established:
switcher hot loop (input capacitor first and closest) and feedback routing
away from the inductor.

**Renesas R01AN0628**, *Guidelines for Full-Speed USB2.0 Board Design*;
**TI SNLA387**, *Ethernet PHY PCB Design Layout Checklist*; **TI SPRACP4**.
Established: interface-specific skew and impedance limits (E4, E5).

**Microchip dsPIC33AK512MPS512 data sheet §2.7** and **Espressif ESP32
Hardware Design Guidelines** (summary read). Established: crystal within
about 12 mm of its pins with nothing unrelated nearby; ESP32 stackup and
decoupling guidance.

**Remaining E sources** (SNLA187, SLVA959, SLMA002, TUSB2E22 data sheet,
Kamineni and Bogatin 2026, Olney 2012 and 2022, Jouppi 2009, Fan 2011): see
capture E's source table, each with document number and URL.

## 4. First-hand field work

**BREAD slice template reviews, 2026-11-19 to 21** — feastorg/Slice_TEMP_NUCL_S4L-r1
PR #3, Slice_TEMP_NUCL_L4L-r1 PR #4, Slice_TEMP_PICO_L4L-r1 PR #4 and related
boards; distilled in [`field-report.md`](field-report.md). Established, for one
project and one reviewer: a series-part column placed before routing gave three
nets 5, 5 and 4 F.Cu segments, and the same parts placed on routes drawn first
gave 2, 2 and 2 (edd960f against 3d9827f), with identical DRC results and route
lint, while the reviewer rejected the first at a glance. Every board passed DRC
with 0 errors before review, and the reviewer found layout problems on every one.
