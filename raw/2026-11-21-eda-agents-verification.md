# V: verification of captures A to E

Captured 2026-11-21. Every source below was accessed on 2026-11-21. I did not
read the captures' notes or part files, only A to E and the primary sources.

## Method

- **How the sample was chosen.**
  1. Every headline number that a capture's summary, tally or method table
     rests on: the A mode and thread counts, B's tally, E's grade counts, D's
     ablation figures (PCBSchemaGen, PCBWorld, SMPS, PCBRouteAgent, HWE-Bench,
     pcbGPT, EEBench), and C's only A/B measurement (mcp-server-kicad).
  2. Every E source marked "(summary read)" (Bogatin-90, Bogatin-split,
     KB-pour, Olney-pour, Olney-serp, Jouppi, Fan, ESP32-HDG, MCHP-OSC,
     TUSB2E22), plus four of E's TI PDFs as a control.
  3. A: every sixth failure-mode row (6, 12, 18, 24, 30, 36, 42), plus three
     of the rows A itself says rest only on a summarised forum or blog page
     (11, 14, 39), plus rows whose instances I had already fetched (3, 5, 9,
     21, 22, 35, 43). B: every sixth row (6, 12, 18, 24, 30, 36), plus rows 3,
     9 and 32, which other captures' sources touched.
  4. C: four CHECKED rules opened at the cited SHA (florianuhlemann D5,
     jvanderberg `pour_check.py`, alexchunlin buckets and `refplane` /
     `return_via`, kicad-happy DC-001), plus kicad-mcp-pro #1381 and C's one
     open citation (IxTechCrypto's arXiv ID).
  5. "Too neat": D's claim that HWE-Bench's text contradicts its tables, D's
     "feedback adds about as much as grounding", D's "90° corner mitred to 45°".
- **How sources were read.** arXiv papers as HTML full text with `curl`
  (arxiv.org), converted to text with a stdlib HTML parser; math values that
  the converter dropped were read from the HTML. HN comments through the
  Algolia items API, raw. Blogs, forums, vendor pages and journal articles with
  `curl`, raw. TI PDFs with `curl` and `pdftotext -layout`. GitHub files with
  `gh api -H "Accept: application/vnd.github.raw" .../contents/<path>?ref=<SHA>`
  at the SHA the capture cites. No host was refused. No summariser was used.
- **Recounts.** B's tally:
  `grep -oE '\| \*\*(T|[1-6])\*\*' B-success-claims.md | sort | uniq -c`.
  A's modes: `grep -cE '^\| [0-9]+ \|' A-critique-harvest.md`. E's grades: the
  grade column of E's summary table, `sort | uniq -c`.
- **Verdicts.** CONFIRMED (the source says it), WRONG (the source says
  otherwise, or the stated thing is not there), DISTORTED (right direction,
  wrong or added detail), UNVERIFIABLE (could not be settled from a primary
  source).

## Checked claims

All URLs accessed 2026-11-21.

| # | capture, location | claim as written | what the primary source says | verdict | source |
| --- | --- | --- | --- | --- | --- |
| A1 | A, "Counted modes" and "Count" | 44 mode rows; 72 threads = 41 HN + 9 EEVblog + 12 KiCad forum + 4 Hackaday + 6 articles | `grep -c` gives 44 rows; the thread list is numbered 1 to 72 in those groups | CONFIRMED | A-critique-harvest.md |
| A2 | A row 3 | models asked to QC changed copied known-good blocks and switched I2C to SPI "for no reason" | comment says exactly that, plus overlapping symbols and labels | CONFIRMED | https://news.ycombinator.com/item?id=49740008 |
| A3 | A row 5 | Gemini insisted a QFN *RGER TPS2596 variant exists | "Gemini hallucinate a QFN version of the TPS2596 ... so confident that the *RGER variant existed" | CONFIRMED | https://news.ycombinator.com/item?id=46680980 |
| A4 | A row 6 | "They love 741 op-amps"; must say "active on Digikey" or it recommends obsolete parts | both comments say so | CONFIRMED | https://news.ycombinator.com/item?id=49570746 ; https://news.ycombinator.com/item?id=46683567 |
| A5 | A row 9 | 22 µF nominal gave 11.4 µF at 4.7 V against 545 µF; rail below brownout at 0.85 ms against 20 ms | same figures; the rail falls below the 3.0 V brownout threshold at 0.85 ms | CONFIRMED | https://eebench.org/blog/can-ai-design-circuit-boards-yet/ |
| A6 | A row 11 (forum/blog only) | ISENSE and ISET merged by overlapping labels, ERC only warned, found by pin-by-pin netlist comparison; LM358 units stacked | blog says the same in prose and in its issue table | CONFIRMED | https://jlcpcb.com/blog/kicad-mcp-how-to-design-a-pcb-with-claude-code |
| A7 | A row 12 | Claude reading `.kicad_sch` directly invented pin numbers | "happily invented pin numbers that didn't exist"; fixed by reading analyzer JSON | CONFIRMED | https://news.ycombinator.com/item?id=47802550 |
| A8 | A row 14 (forum only) | `create_schematic` returned failure and no file (2026-01-03); calls to functions that do not exist (2025-10-18) | page 2 post of 2026-01-03 lists `create_schematic` returning `"success": false` with no file; post of 2025-10-18 says the methods requested "aren't even real" kicad_skip methods | CONFIRMED | https://forum.kicad.info/t/kicad-mcp-server/60704 (and `?page=2`) |
| A9 | A row 18 | earlier models rarely revised layouts; Diode made many boards "95% complete but unusable" | article says both, in those words | CONFIRMED | https://www.anthropic.com/research/claude-electronics-design |
| A10 | A rows 21, 15 | 65 DRC errors; Freerouting plateaued at 69 of 118, 49 left; W25Q128JVS SOIC-8 wide on SOP-8 pads | blog gives the same numbers and the same package mismatch | CONFIRMED | https://a6mzero.com/posts/this-pcb-is-brought-to-you-by-fable-5/ |
| A11 | A row 22 | agent snakes thin traces through SMD pins; 10 to 30 small bends instead of two 45° turns; boards "generally functional" | comment says so | CONFIRMED | https://news.ycombinator.com/item?id=50117733 |
| A12 | A row 24 | regulator FB routed beside SW, fixed with a 1.2 mm analog keepout | blog says so | CONFIRMED | https://jlcpcb.com/blog/kicad-mcp-how-to-design-a-pcb-with-claude-code |
| A13 | A row 30 | two silkscreens swapped (49571840); silkscreen overlapped (48800564); 47 silkscreen warnings to 2 (JLCPCB) | all three sources say so; both HN boards worked first time | CONFIRMED | https://news.ycombinator.com/item?id=49571840 ; https://news.ycombinator.com/item?id=48800564 ; JLCPCB URL above |
| A14 | A row 35 | Opus built boards and SPICE runs, claimed a breakthrough; none of the boards worked | comment says so | CONFIRMED | https://news.ycombinator.com/item?id=47802093 |
| A15 | A row 36 | an LLM affirmed both "three parallel decouplers" and "single 1 µF" depending on framing (EEVblog p1, 2026-03-18) | reply #17, 2026-03-18: the poster describes the two-chat test and says "Both will be confirmatory" | CONFIRMED | https://www.eevblog.com/forum/eda/claude-code-for-pcb-design/ |
| A16 | A row 39 (forum only) | beginner pasted text ("These are not my words") calling 499 Ω resistors thermocouple open-detect pull-ups; reviewer showed the resistor was on VCC | both posts are there as described | CONFIRMED | https://www.eevblog.com/forum/projects/pcb-design-482725/ |
| A17 | A row 42 | (via a Reddit PCB review community) people with zero knowledge post AI-generated projects for free review | comment says so | CONFIRMED | https://news.ycombinator.com/item?id=49589156 |
| A18 | A row 43 and HN 50085553 note | triac fan controller: board built and works, one footprint wrong | follow-up comment of 2026-10-30: 36 parts soldered, one capacitor with the wrong footprint, firmware flashed, fan controlled, "worked perfectly" | CONFIRMED | https://news.ycombinator.com/item?id=50299361 |
| A19 | A, notable threads, HN 49695689 | "a tscircuit maintainer" lists the major mistakes across ~15 ordered boards | the comment lists the three mistakes and "~15 unique designs"; the commenter's HN profile says they build tscircuit (name not recorded here) | CONFIRMED | https://news.ycombinator.com/item?id=49736506 |
| B1 | B, "Tally by rung" | rung 5: 2, 4: 4, 3: 1, 2: 9, 1: 5, T: 15; 36 graded | recount gives 5:2, 4:4, 3:1, 2:9, 1:5, T:15 = 36 | CONFIRMED | B-success-claims.md |
| B2 | B row 3 | Anthropic: assembled by Diode; no electrical validation, antenna tuning, thermal test or certification; hub traces rerouted "dozens of times" | article says all of this | CONFIRMED | https://www.anthropic.com/research/claude-electronics-design |
| B3 | B row 6 | Koppar: DRC 0; hub at 480 Mb/s; crystal 12000 kHz; buck 3.90 V no load; loopback −12 / −12.7 dBFS; first version 35 Ω feed, buck 60 mm from inductor, 90 vias in pads, 0.1–0.24 mm neck; built boards lack recovery pads; SIM card-detect backwards | REVIEW.md gives every one of these, and says the EC25 is not yet fitted | CONFIRMED | https://github.com/Koppar-AI/koppar-lte-modem/blob/HEAD/REVIEW.md |
| B4 | B row 9 | XL4015 buck: 2-layer, 63 × 33 mm, 16 nets, 0 ERC / 0 DRC, not fabricated | blog says so ("has not yet been fabricated or bench-tested") | CONFIRMED | https://jlcpcb.com/blog/kicad-mcp-how-to-design-a-pcb-with-claude-code |
| B5 | B row 12 | Astra amp in EasyEDA: 2-layer, 40 parts, 51 vias, "has not been fabricated, assembled, or measured", 50 import mismatches | blog: 44 × 34 mm, 40 fitted SMD parts, 51 plated holes all vias, 50 association mismatches, same not-fabricated sentence. The dropped ground segment was not checked | CONFIRMED | https://jlcpcb.com/blog/gpt-6-astra-pcb-design-in-easyeda-pro |
| B6 | B row 18 | atomic14: nothing wired at first; EN capacitor missing; 330 Ω instead of 10 k; human added ground fills, tidied layout; screenshots only | post says all of this and ends asking whether to send it to PCBWay | CONFIRMED | https://atomic14.substack.com/p/vibe-coding-a-pcb-surprisingly-good |
| B7 | B row 24 | LED earring: 15+ years designer; coin-cell holder missing through-holes, centre pad too small; "They work great!"; 6 days | comment says so | CONFIRMED | https://news.ycombinator.com/item?id=49572155 |
| B8 | B row 27 | FPV breakout boards: DRC passing, fab, "Works exactly to design", "ridiculously simple" | comment says so | CONFIRMED | https://news.ycombinator.com/item?id=49569871 |
| B9 | B row 30 | ~15 RP2040-class designs via tscircuit; "affiliation not stated" | comment text names no affiliation, but the commenter's HN profile says they build tscircuit, so this is vendor-affiliated content | DISTORTED (affiliation is stated on the profile; mark [vendor]) | https://news.ycombinator.com/item?id=49736506 |
| B10 | B row 32 and Gaps | fan controller boards "on their way"; later failure "Unknown; a reply asks for an update"; listed as pending | the update was posted on 2026-10-30 in the same story: built, works, one capacitor footprint wrong | WRONG (stale; outcome published 2026-10-30; rung stays T because nothing is shown) | https://news.ycombinator.com/item?id=50299361 |
| B11 | B row 36 | several PCBs with Fable 5.1; "incredible"; "not perfect"; no build status | comment says so; it also says Fable redesigns when a part is out of stock | CONFIRMED | https://news.ycombinator.com/item?id=50130212 |
| C1 | C, florianuhlemann, `check_decoupling.py` | D1–D7 with D5 a blocker (track path from pin reaches a via before the cap); `--max-dist` 2.0 mm, `--gnd-via-dist` 1.0 mm; exit 1 on blocker or major; planted-failure self-test | file at `ca18b42` matches: D5 blocker, defaults 2.0 / 1.0, `return 1 if summary["blocker"] or summary["major"]`, `--self-test` with planted fixtures | CONFIRMED | https://github.com/florianuhlemann/claude-skills/blob/ca18b425f174bcdaca03dd476ef6ba28baa2338e/pcb-audit/skill/scripts/check_decoupling.py |
| C2 | C, jvanderberg, `pour_check.py` | every pour piece needs ≥2 vias to its plane (1 WEAK, 0 ISOLATED); no track over ≥0.15 mm of void; runs on a refilled copy; exit 1 | file at `7837f97` matches, and stops rather than check stale fills if the refill fails | CONFIRMED | https://github.com/jvanderberg/kicad-skills/blob/7837f97c91f2444a5dc067e3811e9762ac91b7db/skills/kicad-board-review/scripts/pour_check.py |
| C3 | C, alexchunlin, `pcbsig.py` / `pcbcheck.py` | buckets from driver rise time: <1, 1–50, 50–500, ≥500 MHz; `refplane` fails buckets 3–4 above 0 mm, warns bucket 2 above 5 mm; `return_via` 2.0 mm (b3) / 1.0 mm (b4) | knee = 500 / t_rise_ns with those bucket edges; `refplane` `max_gap_mm` 0 and `mid_max_mm` 5; `return_via` 1.0 / 2.0 fail, 5.0 mm warn for bucket 2; `pcbcheck` exits 1 on any fail. Both rules are opt-in config blocks, which C does not say | CONFIRMED | https://github.com/alexchunlin/alex-pcb-skills/tree/f9b288397c2c31c4fd203532b915e699364c7700/skills/kicad-design/scripts |
| C4 | C, kicad-happy rules table, cross-repo table, "Checked rules worth noting" 4 and 5 | DC-001 CHECKED (MEDIUM above 5.0 mm, HIGH above 8.0 mm), and the other EMC rules (DC-003, DP-001, GP-001, RP-001 ...) CHECKED, where CHECKED means "can fail (exit 1, FAIL, or blocker or major)" | thresholds right (`emc_rules.py` lines with `> 8.0` HIGH and `> 5.0` MEDIUM). But `analyze_emc.py` `main()` returns 0 whatever it finds. `fab_release_gate.py` `check_emc` is documented "advisory only — never FAIL": any error-severity EMC finding (HIGH maps to error in `kicad_core/render.py`) yields one `warn`. Only `--strict` ("Treat warnings as failures") turns that warn into FAIL and exit 1. MEDIUM findings (e.g. DC-001 at 5–8 mm) never fail | DISTORTED (fail-capable only under `fab_release_gate.py --strict`, and only at error severity; advisory by default) | https://github.com/aklofas/kicad-happy/tree/6b9767e19979cdef91631573753b1547efdbeab9/skills (emc/scripts/emc_rules.py, emc/scripts/analyze_emc.py, kicad/scripts/fab_release_gate.py) |
| C5 | C, headline and mcp-server-kicad | plain Claude Code 18 of 18 single edits right, with the plugin 3 of 18; 20-edit session both right, plugin ~1.8x context; maintenance mode since October 2026 | README at `f972bfb` says exactly this, same model (Opus 5.5), judged by KiCad 10 netlist/ERC/DRC; test material unpublished | CONFIRMED | https://github.com/ProductOfAmerica/mcp-server-kicad/blob/f972bfb2d340eeb6b7e5d8a95881e88059d5a494/README.md |
| C6 | C, kicad-mcp-pro #1381 | DRC 0 / ERC 0 board with 16 signal PTH rings of 0.125 mm against JLC's 0.18 mm; enlarging leaves 0.09 mm against 0.10 mm; open | issue says so; state OPEN | CONFIRMED | https://github.com/oaslananka/kicad-mcp-pro/issues/1381 |
| C7 | C, Gaps | IxTechCrypto cites "PCBWorld-Bench, arXiv:2607.05915", unchecked | 2607.05915 resolves to "PCBWorld: A Benchmark Environment for Engine-Grounded PCB Design Automation", the paper D read | CONFIRMED (the gap is closed) | https://arxiv.org/abs/2607.05915 |
| D1 | D, PCBSchemaGen and method table | KG ablation 26.8% none, 77.6% component-only, 81.3% schema; 62-task PCBBench, 930 trials, Gemma-4-31B | Table 5 C1 axis: Ovr 26.8 / 77.6 / 81.3, "62-task PCBBench, 930 trials" | CONFIRMED | https://arxiv.org/html/2602.00510 |
| D2 | D, PCBSchemaGen | κ 0.91 vs senior engineers on 300 samples; false accept 6.7% (CI 3.7–11.8); false reject 2.7% | §5: N = 300, κ = 0.91, FA 6.7% (Wilson CI [3.7, 11.8]), FR 2.7% | CONFIRMED | https://arxiv.org/html/2602.00510 |
| D3 | D, PCBSchemaGen "Established" | "Pin-level verifier feedback adds about as much as grounding (57.7% binary feedback vs 81.3% pin-level)" | numbers right (Table 5 D1: 57.7 / 60.4 / 81.3), but removing the KG costs 54.5 pp and binary feedback 23.6 pp; the paper calls the KG "the single largest contribution" | DISTORTED (grounding ~2.3× the feedback effect) | https://arxiv.org/html/2602.00510 |
| D4 | D, PCBSchemaGen | one fabricated 5000 W AC-DC prototype (Figure 5) | Figure 5 and A.21 show a fabricated, populated board; the paper says layout and fabrication used the standard KiCad flow with no framework involvement | CONFIRMED | https://arxiv.org/html/2602.00510 |
| D5 | D, PCBWorld and closed-loop table | GPT-5.4 on D3-A: clean pass 0.65 interactive, 0.19 plan-and-execute, 0.02 engine-free; DRV 1.31 / 16.28 / 34.58; ordering holds across GPT sizes; LLMs 0.00 on D3-B; Freerouting 0.80 D3-A, 0.78 D3-B | Table 4 and Table 3 give those figures; mini 0.28/0.19/0.02, nano 0.30/0.18/0.00. All are best-of-five (@5), which D does not say | CONFIRMED (add "@5, best of five rollouts") | https://arxiv.org/html/2607.05915 |
| D6 | D, SMPS paper and method table | 269 tasks; o3 25.4 / +RAG 44.1 / +SPICE 84.9 / both 90.7; GPT-4o 14.4 / 16.1 / 46.4 / 48.7 | §results text and Table 2 give the same; RAG retrieves from the datasheet | CONFIRMED | https://arxiv.org/html/2507.10639 |
| D7 | D, PCBRouteAgent | CP 1.000 / 0.949 / 1.000 / 0.400 (D2, D3-A, D3-B, D3-C); baselines 0.810 PPO, 0.640 and 0.300 Freerouting; w/o LLM 0.961 / 0.535 / 0.000 / 0.000; D3-B includes retries and angle repair | Tables 1–5 and abstract give the same; six of ten D3-C boards incomplete | CONFIRMED | https://arxiv.org/html/2611.08175 |
| D8 | D, HWE-Bench | best fully correct 8.15% (Claude Sonnet 4.5), GPT-5.2 6.58%, Gemini 3.1 Pro 5.16%; 300 tasks; datasheets supplied | Table V and §III say so | CONFIRMED | https://arxiv.org/html/2603.18102 |
| D9 | D, HWE-Bench | "A text claim (dynamic pass rate higher than static) contradicts its own tables" | the text says the average "drops from 71.84% in the static phase to 58.65%", matching Table III and Table IV averages; every model is lower dynamic than static; arXiv lists only v1 | WRONG (no such contradiction in v1) | https://arxiv.org/html/2603.18102 ; https://export.arxiv.org/api/query?id_list=2603.18102 |
| D10 | D, pcbGPT | pass@1 0.90 (GPT-5.3-Codex) on 20 tasks, 0.72 on hard; 68 of 115 failures wrong or missing supporting parts, 46 interface; human agreement 97.5% over 400 runs | abstract, §results and failure table say so (68 = 59.1%, 46 = 40.0% of 115) | CONFIRMED | https://arxiv.org/html/2606.01188 |
| D11 | D, 2608.31006 | bias point over the 2.25 V VCEO limit, caught by the agent; all results simulated, prototype pending; 75 nodes and 18 nets checked | paper says VCEO = 2.25 V, "All performance figures are simulation results, as the prototype is pending fabrication and measurement", 75 nodes and 18 nets | CONFIRMED | https://arxiv.org/html/2608.31006 |
| D12 | D, 2608.31006 | engineer caught "a 90° feed corner (mitred to 45°)" | paper says only "the corner in the feed line received a miter"; no angle is given | DISTORTED (angles added) | https://arxiv.org/html/2608.31006 |
| D13 | D, atopile/EEBench | 13 V1 tasks; Opus 5 61.6%, Grok 4.6 57.1%, Fable 5.1 56.4%, Fable 5 54.3%, Opus 4.8 Max 51.4%; built and funded by the atopile team | blog says so | CONFIRMED | https://eebench.org/blog/can-ai-design-circuit-boards-yet/ |
| E1 | E, Summary, grade-count line | "Grade counts (18 rows): REAL 4, CONDITIONAL 11, FOLKLORE 2, not graded 1" | the summary table has 19 rows (15a and 15b separate); CONDITIONAL rows are 3, 4, 5, 8, 9, 10, 13, 14, 15a, 16, 17, 18 = 12 | WRONG (19 rows, CONDITIONAL 12) | E-grading.md |
| E2 | E §1, Bogatin-90 (summary read) | ~1.7 fF per mil of width; −15 dB criterion; 5 mil to ~70 GHz; 20 mil transparent below 25 GHz; 120 mil matters ~5 GHz, −10 dB at 10 GHz; tip-radiation only as a reported belief | article gives all of these; the 25 GHz figure is for Shlepnev's measured 20.5 mil trace | CONFIRMED | https://www.signalintegrityjournal.com/articles/2104-should-worry-about-90-degree-bends-in-circuit-board-traces |
| E3 | E §§6–7, Bogatin-split (summary read) | return follows signal above ~10 kHz; 2 kHz test on a two-layer board; loop mutual inductance ~0.4 nH to ~0.25 nH | article says so | CONFIRMED | https://signalintegrityjournal.com/articles/2982-the-case-for-split-ground-planes |
| E4 | E §§8–9, KB-pour (summary read) | f ≈ 3 GHz / d; d < 1.5 in / BW; <50 mil at 30 GHz; never leave pour floating; 1-inch pour ~3 GHz; no effect at 10W; ~5–10 dB at 5W | article: same formulas and figures; at 5w NEXT −40 to −45 dB and FEXT −35 to −45 dB; at 10w "no difference" | CONFIRMED | https://www.signalintegrityjournal.com/articles/4282-the-role-of-copper-pour-and-picket-fence-vias-in-digital-designs |
| E5 | E §§8–9, Olney-pour (summary read) | stitch at < λ/4; floating copper "a real hazard"; pull pours back ≥20 mil from pairs | article says all three | CONFIRMED | https://iconnect007.com/article/132292/beyond-design-copper-pours-in-highspeed-design/132295/design |
| E6 | E §14, Olney-serp (summary read) | closely coupled microstrip serpentine leads by 150 ps on 12 in (~25 ps at 2 in); stripline 5× serpentine lags 10 ps (1.66 ps at 2 in); compared with Johnson | article says so | CONFIRMED | https://iconnect007.com/article/65583/beyond-design-a-new-slant-on-matchedlength-routing/65586/design |
| E7 | E §10, Jouppi (summary read) | IPC-2221 internal chart not based on testing internal conductors; internal ≈ external rise; 100 °C by the old chart can be 10 °C; internal chart gives half the current | article says all of this | CONFIRMED | https://pcdandf.com/pcdesign/index.php/2009-archive-articles/5305-the-new-ipc-2152 |
| E8 | E §7, Fan (summary read) | split-related crosstalk dominates beyond 0.7 mm separation; grows with faster rise times | article says so, and calls split-related crosstalk "relatively weak" | CONFIRMED | https://ewh.ieee.org/soc/emcs/acstrial/newsletters/spring11/DesignTips.html |
| E9 | E §§3, 10, 11, 17, ESP32-HDG (summary read) | crystal ≥2.7 mm from the clock pin; main 3.3 V trace ≥25 mil; 10 µF on RF power pins 3 and 4; L1 signal / L2 GND / L3 power / L4 few signals | guide says all of these | CONFIRMED | https://docs.espressif.com/projects/esp-hardware-design-guidelines/en/latest/esp32/pcb-layout-design.html |
| E10 | E §11, MCHP-OSC (summary read) | ≤12 mm (half inch) from pins, same side, grounded pour tied to MCU ground, no traces on the opposite side, guard traces returned to ground | datasheet text says so | CONFIRMED | https://onlinedocs.microchip.com/oxy/GUID-E48B4A26-F201-4F0A-BCBA-16461582816A-en-US-4/GUID-AA04B64F-3C38-4E1C-8B51-49DE3CFE2419.html |
| E11 | E §4, TUSB2E22 (summary read) | FS rise time 4–20 ns citing USB 2.0 Figs 7-8, 7-9 | TFR and TFF 4 to 20 ns with that test condition | CONFIRMED | https://ti.com/document-viewer/lit/html/SNLS648C/GUID-99E69C89-4597-4B9D-BDFC-025499149AD4 |
| E12 | E, TI PDFs (control) | SPRABV2 §3 quote on trace length; SZZA009 "95% of the effectiveness" and the 50 kHz autorouter line; SPRAAR7 200 mil stitching, App. A USB2 50 mil skew, 4000–12000 mil, 4 vias; SNLA387 20 / 50 mil matching | all present in the PDFs as quoted | CONFIRMED | https://www.ti.com/lit/pdf/sprabv2 ; https://www.ti.com/lit/pdf/szza009 ; https://www.ti.com/lit/pdf/spraar7 ; https://www.ti.com/lit/pdf/snla387 |

## Per-capture summary

Counted from the table above (62 rows).

| capture | rows | CONFIRMED | DISTORTED | WRONG | UNVERIFIABLE |
| --- | --- | --- | --- | --- | --- |
| A | 19 | 19 | 0 | 0 | 0 |
| B | 11 | 9 | 1 | 1 | 0 |
| C | 7 | 6 | 1 | 0 | 0 |
| D | 13 | 10 | 2 | 1 | 0 |
| E | 12 | 11 | 0 | 1 | 0 |
| all | 62 | 55 | 4 | 3 | 0 |

- **A** held up completely, including the three forum-only rows it asked V to
  re-read (11, 14, 39). The summariser did not distort what was sampled.
- **B**'s tally recounts exactly. One row is stale and one misses a vendor
  affiliation.
- **C**'s code readings are accurate on thresholds and exit paths, with one
  labelling inconsistency (C4) that matters for its "checked" claims.
- **D**'s numbers, though read through a summariser, all match the papers. The
  three problems are interpretive sentences, not figures.
- **E**'s ten summary-read sources all match the pages; only its own count
  line is wrong.

## Corrections needed

1. **C4 (qualifies a conclusion).** kicad-happy's EMC rules (DC-001, DC-002,
   DC-003, DP-001, GP-001, RP-001, XT-001 and the rest in `emc_rules.py`)
   measure and grade, but do not fail by default. `analyze_emc.py` returns 0
   whatever it finds. `fab_release_gate.py` folds all EMC findings into one
   check that is "advisory only — never FAIL": a `warn` when any finding has
   error severity (HIGH or CRITICAL). The gate exits 1 on FAIL
   (`return 1 if result["overall_status"] == "FAIL"`), and only `--strict`
   turns that warn into a FAIL. MEDIUM findings, such as DC-001 between 5 and
   8 mm, never fail.
   - Relabel these rules "CHECKED, warn only (fails under `--strict` at error
     severity)" in the kicad-happy table, the cross-repo table, and "Checked
     rules worth noting" items 4 and 5. That is the same class C gives
     kicad-mcp-pro's EMC checks.
   - The rest of the fab gate does FAIL by default (routing, BOM, DFM,
     consistency); that part of C stands.
2. **D3 (changes the method finding's emphasis).** In PCBSchemaGen, grounding
   is the larger effect. Removing the datasheet-derived KG costs 54.5 pp
   (81.3 → 26.8); binary in place of pin-level feedback costs 23.6 pp
   (81.3 → 57.7). The paper calls the KG "the single largest contribution".
   Replace "adds about as much as grounding" with "adds about 24 pp, against
   about 55 pp for grounding".
3. **D9.** Delete the sentence that HWE-Bench's text contradicts its tables.
   In v1, the only version, text and tables agree: static average 71.84%,
   dynamic 58.65%.
4. **D12.** In 2608.31006 the engineer had "the corner in the feed line" mitred.
   The paper gives no angle. Drop "90°" and "to 45°".
5. **D5 (wording).** PCBWorld's figures are @5, best of five rollouts.
   PCBRouteAgent quotes the same GPT-5.4 agent at 42% on D3-A, not 0.65,
   presumably on another protocol. Say "@5" wherever 0.65 / 0.19 / 0.02 is
   quoted.
6. **B10.** Row 32: the outcome was posted on 2026-10-30 (HN 50299361). The
   board was built, one capacitor footprint was wrong, and it works. Rung stays
   T. Set "later failure" to "one capacitor footprint wrong, worked around; works
   (follow-up 50299361)", and remove row 32 from the Gaps "follow-ups not yet
   published" list. The pattern paragraph can add it to the first-hand reports
   that admit a fault fixed by hand.
7. **B9.** Row 30: the commenter's HN profile states the tscircuit affiliation.
   Mark it vendor-affiliated.
8. **E1.** "Grade counts (19 rows): REAL 4, CONDITIONAL 12, FOLKLORE 2, not
   graded 1."

None of these touches a failure mode, a grade or a rung. The B tally, A's mode
list and every E grade stand.

## Gaps

- **Images were not opened.** B's rungs 3 to 5 rest on photos (rows 1, 3, 4,
  6, 7, 14). I confirmed the text around them, not that the photos show
  fabricated or running boards.
- **C's tally (~134 CHECKED, ~100 STATED, ~13 MEASURED) was not recounted.**
  C calls it rough. Correction 1 lowers the share that fails by default. I did
  not count by how much.
- **Not sampled:** A rows 1, 19, 27, 31, 33 and 34 (forum- or blog-only rows
  A flagged); D's venue-abstract papers (PCBInnoBench, EDA Bench, PCB Gym), the
  Circuit Mind / LANL claim, Copperhead and copperbench, Quilter's Speedrun
  page; C's Konnect, KiCAD-MCP-Server and IxTechCrypto code; E's SPRACP4,
  SLYT512, SLYT614, SNVA021, SLVA959 and SLMA002.
- **A's "AI-specific?" judgements and E's grades** are reasoning, not
  citations. I checked the sources they rest on, not the judgement.
- **Reddit** was not read (brief, Decision 1).
- I fetched the commenter's HN profile for B9 and A19 to check an affiliation.
  No username appears in this file.
