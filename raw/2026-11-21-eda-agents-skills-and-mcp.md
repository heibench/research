# Workstream C: agent skills and MCP servers for KiCad (sub-question 7)

Captured 2026-11-21 for `topics/eda-agents/brief.md`, workstream C. All sources
were accessed 2026-11-21.

## Method

- **Source code.** I read each repo from its default-branch tarball
  (`curl https://codeload.github.com/<owner>/<repo>/tar.gz/HEAD`). The SHA comes
  from `git get-tar-commit-id` and the commit time from the tarball entries
  (`TZ=UTC tar tvzf`).
- **Metadata.** Licence, stars and archive state come from `gh repo view --json`
  on 2026-11-21. Issues come from
  `gh issue list -R <repo> --state all --limit 100 --json number,title,state,createdAt`,
  and I opened the relevant ones with `gh issue view`.
- **What I read.** README, every `SKILL.md` and the references it points to, and
  the checking code. I found that code by grepping for the rule's keyword and
  then reading the function and its exit path.
- **Repo identification.** I found the PyPI packages' repos from
  `pypi.org/pypi/<name>/json`:
  - `mcp-server-kicad` is ProductOfAmerica/mcp-server-kicad.
  - `kicad-mcp` is Huaqiu-Electronics/kicad-mcp. That differs from the
    better-known lamaalrajih/kicad-mcp, which I also read.
  
  `gh search repos Konnect kicad` found Konnect's successor,
  Orchis-ai-LLC/Konnect-EDA.
- **Division of work.** Two parallel passes read kicad-happy with
  kicad-mcp-pro, and the five MCP servers. I read the other nine skill repos and
  merged the results.
- **Status labels.** Each rule gets one of four:
  - **CHECKED**: code measures the quantity and can fail (exit 1, FAIL, or
    blocker or major).
  - **MEASURED**: code reports the number but leaves the verdict to an agent
    or a human.
  - **STATED**: prose, a checklist, or an MCP prompt the agent is asked to
    follow.
  - **APPLIED**: a generator builds the rule into its output but never judges
    an existing design.
- **Not done.** I ran none of the tools; the brief rules that out. A threshold
  appears below only if I read it in the file named. Where an item says "not
  read in detail", the code exists and I did not read its threshold.
- **Writing.** The skill text is paraphrased. Short quotes appear only where
  the wording is the evidence.

| repo | licence | KiCad | HEAD SHA | commit (UTC) | stars 2026-11-21 |
| --- | --- | --- | --- | --- | --- |
| aklofas/kicad-happy | MIT | 5–10 (README) | `6b9767e19979cdef91631573753b1547efdbeab9` | 2026-11-15 | 1725 |
| IxTechCrypto/kicad-skills | MIT | 10 (8, 9) | `f187be5cc48ae8f5fcb48d21591500f1bf2a4046` | 2026-11-17 | 14 |
| roccoagain/kicad-agent-skills | MIT | 10 | `f9f97796ba56ecf9530e752285b08fe3aa7c89de` | 2026-11-09 | 1 |
| jvanderberg/kicad-skills | MIT | 9, 10 | `7837f97c91f2444a5dc067e3811e9762ac91b7db` | 2026-11-02 | 5 |
| florianuhlemann/claude-skills | CC-BY-SA-4.0 | 10 | `ca18b425f174bcdaca03dd476ef6ba28baa2338e` | 2026-10-19 | 0 |
| haohao-0725/PCB_Layout_with_AGENT_in_KiCAD | MIT | 10 | `5096ac03dda7cc4438d9ad5e9a3d2481e923d11f` | 2026-11-02 | 0 |
| Novin3dp/claude-KiCad-pcb-designer-skill | MIT | 9, 10 | `90ca2236794b77c56a2f0f5b7b517bb24d737465` | 2026-11-06 | 4 |
| alexchunlin/alex-pcb-skills | none | 10.0.1 | `f9b288397c2c31c4fd203532b915e699364c7700` | 2026-11-05 | 1 |
| Prithvi-0g/claude-kicad-skills | none | 7+ | `7012a3135b3cce9d11f6657812bfeef6e865d872` | 2026-05-07 | 2 |
| 1999AZZAR/pcb-skill | MIT | 9 | `aa581337b86d55f751df9ded2f3c0bb9d209baa5` | 2026-09-15 | 3 |
| oaslananka/kicad-mcp-pro | AGPL-3.0 | 10 | `04edad8e7ee93a4b74439068a7cce2c6e8951411` | 2026-11-21 | 230 |
| ProductOfAmerica/mcp-server-kicad | GPL-3.0 | 9, 10 | `f972bfb2d340eeb6b7e5d8a95881e88059d5a494` | 2026-10-23 | 16 |
| Huaqiu-Electronics/kicad-mcp | MIT | not stated | `a2a7bf565273c629a67ddd7be4cdb273c6148b75` | 2026-04-20 | 26 |
| lamaalrajih/kicad-mcp | MIT | 9+ | `98c9ea41cb393393a8bafd157a93e84431e00afb` | 2025-10-17 | 537 |
| mixelpixx/KiCAD-MCP-Server | MIT | 9, 10 | `aa3d834b4b9c98b47e629613287adcd939843b46` | 2026-11-21 | 3472 |
| mixelpixx/Konnect (archived) | AGPL-3.0 | 10 | `676efce43c9779f9f9e59a9181cb0746c6452650` | 2026-11-02 | 1463 |
| Orchis-ai-LLC/Konnect-EDA | Other (closed) | 10 | `a7000e7635a6d9529b65ecceb2c6a61b80ece995` | 2026-11-21 | 186 |

## Headline findings

- **Not one of the 17 repos shows a board it produced being fabricated and then
  tested.**
  - KiCAD-MCP-Server #138 is the only statement that a board was ordered, and it
    gives no result ("the results were..... interesting").
  - These repos say outright that nothing was built:
    - alexchunlin's README;
    - 1999AZZAR's case study;
    - kicad-mcp-pro, for the JLCPCB article board;
    - haohao-0725, whose bring-up log is blank after the pre-order paper fit check.
  - Novin3dp's "built and proven" means DRC, ERC and parity at 0.
  - florianuhlemann's lessons-learned describe two boards through revisions and
    "the owner's measurements", but never say plainly that either was built and
    worked.
- **The only A/B measurement of an agent tool against a bare agent** is in
  mcp-server-kicad's README. Plain Claude Code got 18 of 18 edits right; with
  the MCP plugin it got 3 of 18. The authors put the server into maintenance
  mode because of it.
- **The only human-expert calibration** is alexchunlin #11. A board designer's
  ranking disagreed with four model reviewers on the middle of the field:
  - he put his own hand layout in the top tier, where the model reviewers had it sixth;
  - the board built with the repo's own skill came out mid.
- **"DRC 0 is not a good board"** is the most widely shared premise. These
  repos give concrete cases that passed DRC:
  - five nets shorted (1999AZZAR);
  - a drill-origin offset (florianuhlemann);
  - PTH rings below the fab minimum (kicad-mcp-pro #1381);
  - wrong-revision nets (KiCAD-MCP-Server #400);
  - about 10,000 zigzag segments (haohao-0725).
- **The repos that measure the most** are kicad-happy, jvanderberg,
  florianuhlemann and alexchunlin. These are also the ones that cite sources or
  log the finding behind each rule. The high-star MCP servers mostly state
  rules, or check by proxy.

## Per repository

Skill repos first (kicad-happy, then the nine smaller skill sets), then the MCP servers.

### aklofas/kicad-happy

- Licence MIT; stars 1725 (2026-11-21); last commit 2026-11-15T21:59Z,
  SHA `6b9767e19979cdef91631573753b1547efdbeab9`.
- KiCad versions: README table claims full schematic/PCB/Gerber support for
  KiCad 5 through 10.
- What it is: a **review** skill set (kicad, emc, spice, datasheets, bom,
  distributor skills, jlcpcb, pcbway), not a layout generator. The README
  workflow has the human design in KiCad, then the agent reviews.
- How it drives KiCad: parses the `.kicad_sch` / `.kicad_pcb` S-expression
  files and Gerbers with its own stdlib-only Python (`skills/kicad/scripts/`).
  No `pcbnew` or `kipy` import found (grep over `*.py`). `kicad-cli` appears
  as an oracle the analyzer was checked against (comments in
  `schematic/connectivity.py`, `signal_detectors.py`, tests), not as the
  runtime engine. KiCad's own DRC/ERC results are read if present.
- Validation (`VALIDATION.md`): a corpus of 5,858 public KiCad repos; crash
  testing and 2,714,810 regression assertions at 100 % pass. The README says
  plainly that the corpus "checks stability ... It does not prove the output is
  correct." So the validation is regression against its own seeded output, not
  against fabricated boards.

#### Rules

Thresholds below were read in the file named.

| rule | status | file | threshold | source cited |
| --- | --- | --- | --- | --- |
| Decoupler distance from IC (DC-001) | CHECKED | `skills/emc/scripts/emc_rules.py` `check_decoupling_distance`; distance measured power-pad to power-pad in `skills/kicad/scripts/pcb/assembly.py` (`_min_power_pad_distance`, caps must share a non-ground, non-signal net) | MEDIUM above 5.0 mm, HIGH above 8.0 mm; recommendation text says 2-3 mm | `skills/emc/references/pcb-emc-rules.md`: Bogatin EDN rule of thumb #6 (loop inductance per mm), Hubing/LearnEMC connection-inductance note |
| IC with no decoupler (DC-002) | CHECKED | `emc_rules.py` `check_missing_decoupling` | none within 10 mm sharing a supply net | TI SLUA383, ADI MT-101 (per `pcb-emc-rules.md`) |
| Decoupler pad to nearest via (DC-003) | CHECKED | `emc_rules.py` `check_decoupling_via_distance` | flagged above 3.0 mm; ~0.7 nH/mm estimate | LearnEMC, "Estimating the Connection Inductance of Decoupling Capacitors" |
| ESD bypass cap near ESD IC | CHECKED (measured) | `pcb/assembly.py` (`esd_bypass` category) | comment says within 3 mm | none found |
| Recommended decoupler values (100 nF X7R 0402 + 1 µF; 10 nF C0G for high-speed) | STATED (finding recommendation text) | `emc_rules.py` DC-002 | n/a | "Standard 100nF decoupling per IC" (no document) |
| Diff-pair intra-pair skew (DP-001) | CHECKED | `emc_rules.py` `check_diff_pair_skew`, table `DIFF_PAIR_PROTOCOLS` in `emc_formulas.py` | per protocol, e.g. USB-HS 25 ps, USB3 5 ps, Ethernet 50 ps, HDMI 20 ps, PCIe 5 ps, CAN 500 ps; MEDIUM above half the limit, HIGH above it; skew from routed length difference and stackup εr (default 4.4) | comment cites USB 2.0 §7.1.2, USB 3.x §6.8, IEEE 802.3 §40.6.1, HDMI 2.1 §4.2.1.1, TIA/EIA-644 §4.2, PCIe base spec §4.3.3, ISO 11898-2 |
| Diff pair reference plane, layer, common-mode radiation | CHECKED | `emc_rules.py` `check_diff_pair_reference_plane`, `check_diff_pair_layer`, `check_diff_pair_cm_radiation` | not read in detail | |
| Signal crossing a reference-plane gap / plane split (GP-001) | CHECKED | `emc_rules.py` `check_return_path_coverage`; plane-split rule text in `pcb-emc-rules.md` | split counted where a plane net holds > ~2 mm of trace; no finding if a populated cap joining the two plane nets is within 5 mm (`SPLIT_BRIDGE_CAP_MM = 5.0`) | Hubing, "Common PCB Layout Mistakes that Cause EMC Compliance Failures"; Ott, *EMC Engineering* ch. 16 |
| Ground-via stitching spacing | CHECKED | `emc_rules.py` `check_via_stitching`, `emc_formulas.lambda_over_20` | spacing √(area/count) against λ/20 at 3× the highest crystal frequency (50 MHz assumed when none) | Altium article "Everything You Need to Know About Stitching Vias" (λ/20, λ/10) |
| Ground via at signal layer change (RP-001) | CHECKED | `emc_rules.py` `check_layer_transition_stitching`, `_stitch_radius_mm` | within 2× first dielectric thickness, at least 1 mm | Ott, "PCB Stack-Up Part 6"; Sierra Circuits return-path guide |
| Connector area stitching, ground-pour ring, crystal guard pour | CHECKED | `check_connector_area_stitching`, `check_ground_pour_ring`, `check_crystal_guard_ring` | not read in detail | |
| 3H crosstalk spacing (XT-001) | CHECKED | `emc_rules.py` `check_crosstalk_3h_rule` | spacing below 3× dielectric height | Bogatin, *Signal and Power Integrity*, ch. 13 |
| Signal near board edge (BE-001) | CHECKED | `emc_rules.py` `check_trace_near_board_edge` | within 3× dielectric height (0.2 mm assumed); reported when more than 10 segments | none in function |
| Connector ground-pin ratio (IO-002) | CHECKED | `emc_rules.py` `check_connector_ground_pins`; schematic side in `kicad/scripts/domain_detectors.py` | docstring: 1 ground per 4 signal pins, or ≥2 grounds above 4 signals; README example shows "recommended ≤3:1" | "rule of thumb" (docstring) |
| Switching hot-loop area (SW-003), switch-node area | CHECKED | `emc_rules.py` `check_input_cap_loop_area`, `check_switching_node_area` | graded only when measured from pads (v3.0.1 note) | TI SLVA477; Paul ch. 10; Ridley |
| Clock routing, clock near connector | CHECKED | `check_clock_routing`, `check_clock_near_connector` | not read in detail | Armstrong part 5; Johnson ch. 1 (per `pcb-emc-rules.md`) |
| Stackup (signal adjacent to reference, coupling) | CHECKED | `emc_rules.py` `check_stackup` | not read in detail | Ott, "PCB Stack-Up" series |
| PDN impedance | CHECKED (analytical; AC sweep with `--spice-enhanced`) | `check_pdn_impedance`, `check_pdn_distributed` | | README: findings stay heuristic |
| Power trace width vs current (TW-001) | CHECKED | `kicad/scripts/cross_analysis.py` | IPC-2152 width for estimated current, 1 oz, 10 °C rise; current *estimated from regulator output capacitance* | IPC-2152 |
| Fab minimums (track, space, drill, annular ring) | CHECKED | `kicad/scripts/pcb/dfm.py` | JLCPCB standard 0.127/0.127 mm, drill 0.2 mm, annular 0.125 mm; advanced 0.1/0.1/0.15/0.1 mm; IPC-6012 class limits | "JLCPCB capabilities page, verified 2025-01"; IPC-6012 Rev E |
| Fab minimums as prose (edge clearance ≥0.3 mm, 0.5 mm recommended; tables) | STATED | `skills/jlcpcb/SKILL.md` | | |
| Fab release gate (routing complete, BOM MPNs, DFM, schematic↔PCB match, Gerber layers, thermal, EMC) | CHECKED, exits 1 on FAIL | `kicad/scripts/fab_release_gate.py` (README, v3.0.1 note) | | |
| Datasheet coverage (DS-001/002/003) | CHECKED | detector `audit_datasheet_coverage` | DS-001 = no BOM part has datasheet evidence | |
| Do not say "verified"/"per datasheet" without datasheet evidence | STATED, with a gate | `skills/kicad/SKILL.md` (Design Review Contract); evidence gate `skills/kicad/review/scripts/deep_review_gate.py` quarantines Deep Review findings without evidence | | |
| Sourcing: MPN coverage, lifecycle EOL/NRND, temperature grade | CHECKED | detectors `audit_sourcing_gate`, `audit_lifecycle_skipped`; `kicad/scripts/lifecycle_audit.py` (distributor APIs) | | |
| Crystal load caps | CHECKED | detector `validate_crystal_load_caps` | README example: within ±% of target | |
| I²C pull-ups with rise time; LED resistors; CAN termination; voltage levels | CHECKED | `validation_detectors.py` etc. | not read in detail | |
| Capacitor voltage derating | CHECKED | `analyze_voltage_derating` | README: ceramic 50 %, electrolytic 80 % | |
| ESD protection on connectors | CHECKED | detector `audit_esd_protection` | | TI SLVA680, SLVAEX9 cited in `pcb-emc-rules.md` (no numeric distance; 25 mm is called a heuristic there) |
| 90° corners | none found | grep for `acute`, `90°`, `right angle` in `*.py` returned nothing | | |

Unsourced effectiveness claim, attributed: `skills/emc/SKILL.md` says the
analyzer "catches ~70% of common EMC design mistakes" and can cut first-spin
failure "from ~50% toward ~20-30%"; no source or measurement is given for
either figure.

#### Fabrication evidence

None found. Grep over the repo's `*.md` for respin / built / ordered /
bring-up found only generic text. The two example reports
(`example-report-1.md`, `example-report-2.md`) are reviews of existing
open-source boards. No issue reports a board fabricated after a kicad-happy
review.

#### Notable issues (`gh issue list -R aklofas/kicad-happy --state all --limit 100`: 37 returned)

- #39 (closed): GP-001 flagged every via larger than about 0.7 mm as a
  reference-plane gap because the copper search radius (0.5 mm) fell inside
  the via's own antipad; on the reporter's board 62 of 497 samples missed, all
  at 0.8 mm vias. A false-positive class for normal 4-layer plane fan-out.
- #60 (closed): GP-001 missed a trace crossing a 1 mm split between two power
  planes.
- #61 (open): on a KiCad 10.0.7 test board, the MCU was counted as the USB
  pair's ESD protection, a 4-pin USB-B was treated as Type-C, and no PCB-side
  pair finding was produced (suspected `/` sheet-prefix net-name mismatch).
- #62 (closed): switching loop area reported 0 mm² when the three parts' centres
  were collinear.
- #31, #29, #28, #24, #33: further false positives (board edge, courtyard,
  via-in-pad, plane fragmentation, oscillator).
- #11: wrong Vref for a regulator family (prefix match too broad).

### IxTechCrypto/kicad-skills

- MIT. KiCad 10 (README says 9 and 8 also work). HEAD `f187be5cc48ae8f5fcb48d21591500f1bf2a4046`, committed 2026-11-17. 14 stars (`gh repo view`, 2026-11-21). No issues, open or closed.
- **How it drives KiCad:** `kicad-cli` for ERC, DRC with parity and zone refill (`scripts/run_quality_gates.py`); SWIG `pcbnew` for the checks and routing scripts; the README also names the IPC bridge for the OR-Tools placer. External routers: Freerouting, TraceMaker, fastroute.
- **Checked** (`tools/pcb_solver/verify_layout_physics.py`, exits 1 on any violation):
  - a through-hole pin on one side within 1.5 mm of an SMT pad on the other side;
  - copper or parts inside an RF antenna keepout. The zone comes from the caller, or the script guesses it from the antenna footprint's rotation with a fixed box;
  - mounting-hole keepout radius of at least 3.0 mm;
  - a tactile switch within 4.0 mm of a fine-pitch IC;
  - connectors whose mating face points into the board instead of out to the nearest edge;
  - every part's pad within 1.8 mm of a track end or via. This is a crude "is it routed" test, not connectivity.
  The script hard-codes `C:\Program Files\KiCad\10.0\bin` on `sys.path`. `route_and_verify.py` runs DRC after each net it routes and rolls back on a new violation.
- **Stated only:**
  - decoupling: every IC power pin gets a local 100 nF within 2.0 mm (`skills/kicad-10-workflow/SKILL.md`);
  - intra-pair skew of 5 mil (0.127 mm) or less; 100 Ω differential, 90 Ω USB (`kicad-highspeed`, `kicad-core`);
  - a ground stitching via within 1.0 mm of a signal via that changes reference plane;
  - spacing of at least max(2W, 3H), and guard traces stitched every 5 mm;
  - RF via fence at λ/20, which it puts at about 3 mm;
  - one 0.3 mm via carries 1.5 to 2.0 A;
  - thermal-via grids;
  - an IPC-2152 width table;
  - footprint pins parsed from the datasheet's pin table (`kicad-newpart`);
  - `--no-tracks-on In1.Cu` passed to the router to keep the 4-layer ground plane whole.
- **A claim the code does not back:** the docstring of `tools/pcb_solver/pcb_solver.py` lists "Decoupling & Power Proximity Constraints (< 2.0mm)". The file mentions decoupling nowhere else (`grep -n -i decoupl`), so the constraint is described but not implemented.
- **Sources cited:** a PCB Runner blog post, a Phil's Lab video, the Saturn PCB Toolkit, IPC-2152, and "PCBWorld-Bench, arXiv:2607.05915". The README also recommends models by name ("Gemini 4 Argon"). I did not check whether that arXiv ID resolves; workstream D or V should.
- **Fabrication:** none claimed. `evals/` sets expected clean-pass rates per complexity tier but holds no results.

### roccoagain/kicad-agent-skills

- MIT. KiCad 10 ("tested with 10.0.5 on macOS"). HEAD `f9f97796ba56ecf9530e752285b08fe3aa7c89de`, committed 2026-11-09. 1 star (2026-11-21). No issues.
- **How it drives KiCad:** SWIG `pcbnew` from KiCad's bundled Python (`skills/kicad-board-edit/board.py`); its own S-expression editing for schematics (`sch.py`); `kicad-cli` and jobsets for checks and exports.
- **Checked:**
  - ERC, DRC with parity, and JLCPCB's capability limits plus its "recommended" values as `.kicad_dru` rule packs. These are KiCad's own DRC with custom rules. The source is the JLC capabilities page, read 2026-11-05 (`skills/kicad-check/check.py`, `jlcpcb-*.kicad_dru`). Exits 1.
  - Schematic decoupling *presence*: every `power_in` rail of every part has at least one capacitor to ground (`skills/kicad-view/view.py decoupling`). Exits 1 on a rail with none.
  - Expected pin nets from a list (`view.py expect`). Exits 1.
- **Measured, but no pass/fail** (`board.py score` and `board.py nets`):
  - each capacitor's rail-pad distance to the nearest IC pad on that rail;
  - for each signal via, the distance to the nearest ground via;
  - per-net routed length and narrowest track.
  The layout-review skill gives the thresholds and leaves the verdict to the agent.
- **Stated** (`skills/kicad-layout-review/SKILL.md`):
  - a decoupler within about 2 mm "or the datasheet's distance", on the same side, between the supply's arrival and the pin, with its ground via within about 1 mm;
  - a ground via within about 1.5 mm of each fast signal via;
  - unbroken ground under fast tracks, and no crossing of splits;
  - pairs with the same width, gap and via count, length-matched to the interface's tolerance;
  - stitching along pour edges;
  - about 1 A per 0.3 mm via;
  - smallest switcher hot loop, crystal loops, and every datasheet layout requirement listed with its result.
  
  `kicad-routing` states IPC-2221 widths at a 10 °C rise and IPC-2221 B2 spacing above 30 V. `kicad-part-selection` sets four conditions before a part counts as chosen: an orderable part number, a datasheet that proves its ratings, stock, and a footprint matched by dimensions. It also covers DC-bias derating, rejecting NRND parts, and suffix-dependent pinouts.
- **Fabrication:** none claimed. `tests/smoke.py` builds a synthetic board, and `tests/evals.json` holds task-level evals with expected behaviour.

### jvanderberg/kicad-skills

- MIT. KiCad 9 and 10. HEAD `7837f97c91f2444a5dc067e3811e9762ac91b7db`, committed 2026-11-02. 5 stars (2026-11-21). Six issues, all closed, filed 2026-10-24 to 10-29, all tool bugs. #1 is the design-relevant one: a hand-written via placer missed same-net hole-to-hole spacing, so `router.py` now checks hole-to-hole on any net.
- **How it drives KiCad:**
  - `kicad-cli` for DRC (zones refilled twice), ERC, and netlists;
  - SWIG `pcbnew` through KiCad's Python for `boarddump.py` and the lints;
  - its own lossless S-expression layer (`scripts/kicad_sexpr/`) for writing;
  - shapely, numpy and scipy for the analysis pack.
- **Checked** (each exits 1 on a finding):
  - `refparts.py`: each IC's datasheet typical application, written per IC into `reference-parts.json` with the figure cited (for example "SLVSE52A fig. 13 / fig. 21"), checked against the design. It names the part that satisfies each entry, or reports MISSING, WRONG VALUE (with tolerance), FAR (`max_mm` from the datasheet layout figure) or AMBIGUOUS. It handles hierarchical instances.
  - `pour_check.py`: every pour piece has at least 2 vias to its own plane (one is WEAK, none is ISOLATED), and no signal track runs over 0.15 mm or more of void on its reference layer. It runs on a refilled copy.
  - `board_lint.py` covers "checks KiCad's DRC does not make":
    - silk text over another part's body;
    - vias on or touching a pad of their own net (DRC skips same-net copper);
    - missing 3D model files;
    - overlap of parts that have no courtyard;
    - paste apertures over drilled holes.
  - `islands.py`: declared single-point or quiet grounds are one piece.
  - `fpcheck.py`: footprint against the package string and symbol.
  - `netspec.py`: the intended netlist against KiCad's.
  - `partfields.py`: every BOM part has a datasheet link and an LCSC or MPN, matching in schematic and board.
  - `part_gate.py`: lifecycle from TI product pages and LCSC stock per exact orderable variant, in the assembler's region.
  - `bom_check.py`: stock, package and assembly class across the BOM.
  - `router.py`: clearance, hole-to-hole, vias on same-net pads and board edge, before writing.
- **Measured, judged by a reviewer agent** (`kicad-board-review/scripts/make_pack.sh`):
  - `decoupling.py`: per IC supply pin, the nearest capacitor *by copper path* through tracks, vias and planes, with KiCad's connectivity as the join. It estimates the loop inductance from microstrip Z0 and a via formula. Pins beyond `max_mm` (default 5.0 mm, no source given) are flagged; a pin with no reachable capacitor is a FAIL.
  - `emc.py`:
    - reference-plane continuity under every signal track, sampled every 0.1 mm and ranked by severity;
    - crosstalk parallel runs;
    - signal via to nearest ground via;
    - closed-form Z0;
    - differential-pair length and skew;
    - switch-node area;
    - hot loops, each with a DC solve of its return path.
  - `power.py`: a DC resistive-grid IR-drop solve.
  - `thermal.py`: a layered steady-state thermal solve.
- **Stated:** 45° corners (`skills/kicad-pcb-workflow/references/routing.md`), no neck-downs on high-current paths, and "read the datasheet instead of remembering it". The review skill sends the pack to an adversarial reviewer agent (`references/reviewer-brief.md`). The README says the analysis is DC and geometric with no field solving.
- **Method note:** `GAPS-ADDRESSED.md` (141 kB) turns the gaps logged on one real design session, on another project, into numbered general rules (R1 to R22+). Each rule records where it now lives and how it was verified ("Text" when it is prose only, or the script that checks it).
- **Fabrication:** none found. The gap log quotes a JLC price check of 2026-10-30, but I found no statement that a board was built or tested.

### florianuhlemann/claude-skills (pcb-design, pcb-audit)

- CC-BY-SA-4.0. KiCad 10. HEAD `ca18b425f174bcdaca03dd476ef6ba28baa2338e`, committed 2026-10-19. 0 stars (2026-11-21). No issues.
- **How it drives KiCad:** the audit scripts are stdlib Python that parse the `.kicad_pcb`, the netlist export, Gerbers and Excellon directly ("Tier A", so they run without KiCad). "Tier B" adds `kicad-cli` ERC and DRC with parity. `pcb-design` uses SWIG `pcbnew` for edits.
- **Checked.** Every check script carries a `--self-test` with a planted failure it must catch (`pcb-audit/skill/scripts/README.md`).
  - `check_decoupling.py` (exits 1 on blocker or major). Each decoupling cap carries a schematic field `Decouples=<ref>:<pin>`, and the script audits:
    - D1: an unassigned cap;
    - D2: a cap assigned to a pin on another net;
    - D3: a supply pin with no cap;
    - D4: pad-to-pin edge distance over `--max-dist`, default 2.0 mm;
    - **D5 (blocker): the cap feeds the pin through the plane.** Walking same-net tracks from the pin never reaches the cap's pad without passing a via;
    - D6: the nearest cap is not the assigned one;
    - D7: no return-net via within 1.0 mm of the cap's ground pad.
  - `check_fab_files.py` reads the files that get ordered and checks:
    - a flash under every plated drill on both outer layers;
    - all holes inside the outline;
    - the outline equal to the documented size;
    - the drill table equal to the board's.
    
    It was added after a drill-origin offset passed DRC, ERC and the renders (`references/lessons-learned.md`).
  - `check_track_geometry.py`: segments off the 45° grid, acute corners, 45° T-branches, zero-length and duplicate segments.
  - `check_entry_angles.py`: two-pin pad exits within 45° of the pad axis, IC pins exiting along the long axis, no bend inside a pad.
  
  These two lints exit 1 with `--strict`; otherwise the findings are reviewed at the gate.
  - `net_path.py --pairs`: routed length between pads against every length a review document claims.
  - `drc_gate.py`: a warning passes only with an allowlist line that carries a justification, and stale lines fail. It exists because "kicad-cli 10 ignores the project's DRC exclusions".
  - `lint_stale_values.py`: superseded values must not survive in the docs.
- **Stated** (`pcb-design/skill/SKILL.md`):
  - GND stitching on a grid of about 10 mm, tightened to about 5 mm or λ/20 near RF and along edges, plus a GND via at every decoupling cap;
  - length matching only for differential pairs (USB ±0.15 mm) and for buses above about 10 MHz or with edges under 5 ns (±0.5 mm);
  - impedance from JLC's calculator for the actual stack;
  - a part enters the schematic only with an LCSC number, a live category, stock of at least quantity × count plus attrition, and an assembly type;
  - a "deep read" of the fitted vendor's datasheet.
- **Fabrication:** `references/lessons-learned.md` records two boards. Board 1: "four revisions 0.1 → 1.0", 4-layer with economic PCBA. Board 2: "six tags before the first build". It mentions "the owner's measurements". It does not say plainly that either board was built and worked, so I record this as unconfirmed. Two lessons are evidence in their own right:
  - On Board 1, 27 of 41 two-pin parts had a trace leaving at 60° or more off the pad axis. The autorouter had routed around rotations chosen from the schematic, and "no check looked at flow". This led to the entry-angle lint.
  - On Board 2, "layout done the autorouter's way": a feedback trace on B.Cu slotting the only plane, a 0.4 mm thread into the buck input, and a switch-node bridge under the input capacitor.

### haohao-0725/PCB_Layout_with_AGENT_in_KiCAD (`kicad-clean-pcb`)

- MIT. KiCad 10.0.x. HEAD `5096ac03dda7cc4438d9ad5e9a3d2481e923d11f`, committed 2026-11-02. 0 stars (2026-11-21). No issues.
- **How it drives KiCad:** its own S-expression reader and writer (`kcp/backends/file.py`), a live IPC API backend through `kipy` (`kcp/backends/ipc.py`, which recommends KiCad 10.0.6 or newer), `kicad-cli` for DRC, ERC and exports, and a Gerber readback script.
- **Checked:** `kcp lint`, a tidiness lint, gives pass, warn or fail per metric against per-preset thresholds (`kcp/presets/lint.json`), and `kcp/cli.py` returns 1 on fail. For the "Tidy" preset:
  - segments per mm of 0.15 or less;
  - at most 10 segments per connection;
  - 0 off-angle segments;
  - at most 1.0 turns per 10 mm;
  - at most 5 jogs;
  - 0 vias on power nets;
  - at most 1 via per signal net;
  - at least 75 % of segments in each layer's main direction;
  - 0 tracks on plane layers;
  - 0 non-ground zones;
  - 0 dangling ends;
  - row misalignment of 0.05 mm or less;
  - plane coverage of at least 0.5.
  
  No source is given for these numbers; they are presented as preferences. `scripts/gerber_readback.py` and `compare_gerbers.py` read the exported fabrication files back.
- **Stated** (`references/layout-rules.md`):
  - decouplers at the power pins;
  - a GND stitching via within about 1 to 2 mm of every signal via that changes reference;
  - dense stitching and a via fence when outer GND pours are used;
  - pairs run together;
  - current ratings at 2 × the measured current ("Tidy" preset).
- **A human check:** the placement is printed 1:1 on paper and checked against the real parts before any routing (checkpoint CP4).
- **Reported failure:** the README gives the origin. The agent's first attempt, with automatic placement and grid routing, passed DRC but had "about 10,000" zigzag segments and four pours. The restructured board had about 600 segments and 30 vias, and a third less area. The late paper check found a USB port blocked by a header, a fuse-holder pitch mismatch, and a duplicated terminal block.
- **Fabrication:** none yet. `examples/stepper-carrier-2axis/BRINGUP.md` has the pre-order 1:1 fit checks filled in, dated 2026-10-30. One of them found that the 470 µF capacitor on hand was Ø7 mm and probably under-rated for 24 V. The power-up and measurement rows are blank.

### Novin3dp/claude-KiCad-pcb-designer-skill

- MIT. KiCad 9 and 10 for the skills, 8 to 10 for the toolkit. HEAD `90ca2236794b77c56a2f0f5b7b517bb24d737465`, committed 2026-11-06. 4 stars (2026-11-21). No issues.
- **How it drives KiCad:** SWIG `pcbnew`. It has its own negotiated-congestion router (`toolkit/kat/ncroute.py` with a C core) and a Python schematic generator.
- **Checked or tuned:** `toolkit/kat/pair_skew.py` *adjusts* intra-pair skew with meanders to targets of 0.3 mm or less for HDMI and 1.0 mm or less for USB and Ethernet, with no source given. `ddr_report.py` reports DDR3 routed lengths ball to ball along the copper. Schematic gates require ERC 0, netcheck 0, and design assertions passing.
- **Stated:** a board with clean DRC but missing nets or untuned pairs is not finished; "automated reviewers both invent problems and find real ones"; a clean report is not proof (examples given: a card slot facing inward, a SoC pin on the wrong rail).
- **Success claim:** the toolkit README says it was "built and proven" on a 6-layer Allwinner H3 + DDR3 SBC. "Proven" there means DRC 0, ERC 0 and parity 0, with no build mentioned. The repo's own status note says the import was checked "statically only", and that the demo and smoke test were not run.
- **Fabrication:** none claimed.

### alexchunlin/alex-pcb-skills

- No licence file (`licenseInfo` null). KiCad 10.0.1, tested on macOS only. HEAD `f9b288397c2c31c4fd203532b915e699364c7700`, committed 2026-11-05; `pushedAt` is 2026-11-11, from another branch. 1 star (2026-11-21). 25 issues, 3 closed.
- **How it drives KiCad:** SWIG `pcbnew` (`pcblib.board`), `kicad-cli` (dual DRC, plain and with a fab rule pack from kicad-druid), Diode's Zener or SKiDL as code-first front ends, and KiCadRoutingTools for `pcb route auto`.
- **Checked** (`skills/kicad-design/scripts/pcbcheck.py`, rows declared in `checks.json`, each citing an internal finding ID from `docs/FINDINGS.md`):
  - decoupling: any `power_in` pin with no cap fails, and the nearest cap must be within `decoupling_max_mm`, default 2.0 mm centre to centre;
  - GND via of a declared cap within a limit;
  - `feeds` and `currents`: a pin on a wide net fed through a via, pour neck or thermal spokes below the declared current (IPC-2221);
  - thermal vias under a thermal pad;
  - `refplane`: a net in signal bucket 3 or 4 off solid ground on the adjacent layer for more than 0 mm fails; bucket 2 warns above 5 mm;
  - `return_via`: a ground via within 2.0 mm (bucket 3) or 1.0 mm (bucket 4) of each signal via;
  - `exposure`: a victim track within 1.0 mm of a switch node;
  - `irdrop`;
  - `gnd_islands`;
  - `edge_margin`;
  - `policy`: board minimums not lowered below the brief;
  - `fields`: MPN, Manufacturer, LCSC and Datasheet on every part;
  - `calcs`: formulas with limits that read values from the netlist;
  - pin maps, jumpers, test points, `regen-check`.
  
  **The signal buckets come from rise time** (`pcbsig.py`; bucket 1 under 1 MHz, 2 from 1 to 50 MHz, 3 from 50 to 500 MHz, 4 at 500 MHz or more, from the driver's `t_rise_ns`). So return-path rules apply only where the edge rate calls for them.
- **Evaluation:**
  - Briefs are scored by an independent reviewer agent on three axes, giving the README's results table.
  - A replay bench of 10 boards and 41 labelled findings, including "MotorGo Plink's real fab bugs".
  - A mutation bench that planted six bug kinds: "the boards' own checks catch 16 of 21, with every miss a missing config row" (README).
- **Human calibration** (issue #11, resolved 2026-11-12). The repo owner, a board designer, ranked seven boards: five agent arms, one older run, and his own hand layout. Four model reviewers had ranked the same boards.
  - Both agreed on the best and worst boards.
  - The owner put his own board and one no-framework agent board in the top tier. The model reviewers had ranked those two sixth and joint fourth.
  - The board made with the repo's own skill came out mid, below two agent boards made without it.
  - His objections were mostly about style: thermal spokes to ground (he wants solid), ground islands removed instead of stitched and kept, traces along the board edge, and long signals not spaced out.
  - Boards with 0 warnings under the 1 mm edge-reserve rule "still looked edge-bound to him". The issue concludes that "the rule as measured does not capture what he sees" (#11).
  - #14 records checker false fails: `edge_margin` measured from the outline's bounding box, and `gnd_islands` did not count castellated pads as ground ties.
- **Fabrication:** README: "No board from this design loop has been manufactured and validated yet". The hero image is captioned as a motor channel "turning on a table", but the same README says nothing has been built. I take the image to be a render; I did not open it. Ordering the two best boards is open issue #3.

### Prithvi-0g/claude-kicad-skills

- No licence file. KiCad 7 or later. HEAD `7012a3135b3cce9d11f6657812bfeef6e865d872`, committed 2026-05-07. 2 stars (2026-11-21). No issues.
- **Derivation:**
  - The skill set (`kicad`, `emc`, `spice`, `bom`, `datasheets`, `digikey`, `mouser`, `lcsc`, `element14`, `jlcpcb`, `pcbway`, `kidoc`) and the analyzer file names match aklofas/kicad-happy.
  - Strings in its scripts still say "kicad-happy", for example `kicad-happy-spice/1.0` as a User-Agent and "Source: kicad-happy part library".
  - The README does not credit kicad-happy (`grep` for "kicad-happy" and "aklofas" in README.md: no match).
  
  So the analysis rules are kicad-happy's at an earlier snapshot; see that section.
- **Its own additions:** `create`, which calls the Anthropic API to write a schematic and place a board, and `autoroute`, which uses Freerouting.
- **Stated:** "Keep decoupling caps within 3 mm of their IC supply pins" is a line in the LLM placement prompt (`skills/create/scripts/generate_pcb.py`, line 227). Nothing measures it afterwards. The skill's limits section says the placement step does not route.
- **Fabrication:** none claimed.

### 1999AZZAR/pcb-skill

- MIT. KiCad 9. HEAD `aa581337b86d55f751df9ded2f3c0bb9d209baa5`, committed 2026-09-15. 3 stars (2026-11-21). No issues.
- **How it drives KiCad:** `kicad-cli`, SWIG `pcbnew`, and direct S-expression edits (`scripts/kicad/kicad_ctl.py`).
- **Checked:** `scripts/verify/` reads the *exported* Gerber, Excellon and 3D files with a parser written from the spec. The rationale: "Verifying it by asking the EDA that produced it proves nothing". It covers:
  - clearance by raster, then by exact geometry;
  - must-connect, must-not-connect and must-be-open nets from the geometry (`netlist_assert.py`);
  - a drill census;
  - mask openings;
  - outline and closure;
  - copper under a keepout, by raster.
  
  `placement/courtyard_check.py` and `body_clearance.py` check 3D bodies against parts.
- **Stated:** "5 Golden Rules" for its 2-layer router: a solid B.Cu ground, a local GND via per SMD pad, orthogonal layer directions, power trunks at the margin, and segregated header columns. Also connector outward orientation per edge.
- **Reported failures** (`docs/case-study.md`, one real project). The board "has not been fabricated, assembled or powered on". It lists nine design-stage defects:
  - five nets silently shorted with DRC reading 0, caught by netlist assertions;
  - a flex socket rotated 180°;
  - an 0805 under a module body;
  - an unreachable battery connector;
  - an antenna keepout that "was only a drawing", with 93.8 % copper under the antenna by Gerber raster;
  - two power rails 2.5× over rating on 0.30 mm, 0.5 oz inner copper, about 25 °C rise by IPC-2221;
  - a pin driven below its absolute minimum;
  - a charger set beyond its package dissipation;
  - three checkers measuring the wrong thing: a pad modelled as its bounding box, merged raster labels, and same-net hole pairs skipped.
  
  It also gives a general lesson: "a footprint's courtyard is not the part".

### oaslananka/kicad-mcp-pro

- Licence AGPL-3.0; stars 230 (2026-11-21); last commit 2026-11-21T16:47Z,
  SHA `04edad8e7ee93a4b74439068a7cce2c6e8951411`; README version 4.21.3.
- KiCad versions (`compatibility.yaml`, updated 2026-10-23): 10.0.x primary,
  latest verified 10.0.7; 8.x deprecated (file-level read only); 9.x dropped;
  11.x preview for headless IPC.
- How it drives KiCad: live edits through the KiCad IPC API via `kipy`
  (`src/kicad_mcp/connection.py`, `kicad/session.py`); ERC/DRC and exports
  through `kicad-cli` (`tools/validation.py`); some checks parse the
  `.kicad_pcb` text (corner detection). `compatibility.yaml` says SWIG `pcbnew`
  is forbidden and a test enforces it.
- Skills: seven `skills/*/SKILL.md` (pcb-design, kicad-design-review,
  schematic-review, drc-check, fabrication-output, wired-subcircuit-design,
  visual-excellence). They are tool-ordering workflows; almost no electrical
  design rule is written as prose in them.
- README "Scope and honesty": SI/PI/EMC/thermal tools are first-order
  closed-form estimates ("typically ~5–10% accuracy"); outputs need qualified
  human review before fabrication.

#### Rules

| rule | status | file | threshold | source cited |
| --- | --- | --- | --- | --- |
| Decoupler distance in placement gate | CHECKED, but only WARN; FAIL only when a declared cap is missing | `tools/validation.py` `_evaluate_decoupling_pair`; default `max_distance_mm = 3.0` in `tools/design_intent_state.py` | power-pad to cap-pad on the same supply net; falls back to footprint-centre distance with a warning that the loop cannot be inferred | none; issue #1582 says hard thresholds need a datasheet or project source |
| Decoupler distance in EMC tool | CHECKED, WARN only | `tools/emc_compliance.py` `_emc_check_decoupling_text`, `_nearest_cap_distance_mm` | 3.0 mm, **footprint centre to footprint centre**, caps filtered to those sharing a non-ground IC net | none |
| Decoupler on the wrong rail is a critical defect | STATED (hard stop in `skills/kicad-design-review/SKILL.md`); placement checks were reworked to use pin/net identity (#1582, closed) | | | |
| Diff-pair skew and width symmetry | CHECKED, WARN only | `tools/emc_compliance.py` `_emc_check_diff_pair_text`; SI service `signal_integrity/differential_pair_skew.py` (three-level verdict) | default 10 ps (`_DEFAULT_DIFF_SKEW_BUDGET_PS`, labelled "conservative default ... no design intent"); width difference ≤ 10 %; EMC tool uses εr 3.0 for delay | none |
| Via stitching | CHECKED, WARN only | `_emc_check_via_stitching_text` | largest nearest-neighbour gap between GND vias ≤ 5.0 mm | none |
| GND via density | CHECKED, WARN only | `_emc_check_ground_via_density_text` | ≥ 0.5 vias/cm² over the board bounding box | none |
| Ground-plane voids | nominally CHECKED; the code only counts GND pours per layer (PASS with ≥2 layers, FAIL with none). The 25 mm² void-area parameter is printed, not measured | `_emc_check_ground_plane_voids_text` | | |
| Return path / reference plane | proxy only: PASS if a GND zone exists on the chosen reference layer; no along-track continuity | `_emc_check_single_return_path_text`, `_emc_check_reference_plane_text` | | |
| Split-plane crossing | proxy only: WARN when a layer carries pours of more than one non-ground net; signal geometry not used | `_emc_check_split_plane_text` | | |
| High-speed track near edge | CHECKED, WARN only | `_emc_check_edge_clearance_text` | against board bounding box, caller's minimum | |
| High-speed stub | proxy: shortest segment length of the net, default 1.0 mm | `_emc_check_high_speed_rules_text` | | |
| Connector near board edge | CHECKED (placement gate violation) | `_evaluate_connectors` | > 5.0 mm from nearest edge | none |
| High-speed interface grouping | CHECKED | `_evaluate_high_speed` | spread > 0.5 × board diagonal is a violation, > 0.3 × a warning | none |
| 90° corners | CHECKED; advisory (WARN) unless the project declares a strict style policy, then a FAIL marked cosmetic, never electrical | `review/routing_style.py`, `_route_90_degree_corners` in `tools/validation.py` | | issue #1581; catalog source label "KiCad MCP Professional Routing Guidelines" (internal) |
| Fab minimums per fabricator | CHECKED | `src/kicad_mcp/dfm_profiles/*.json` (JLCPCB standard/advanced, PCBWay, NextPCB, OSH Park, Eurocircuits) | JLCPCB standard: track/space 0.127 mm, drill 0.3 mm, annular 0.18 mm, copper-to-edge 0.3 mm, PTH ring 2-layer 1 oz min 0.18 / recommended 0.25 mm | `pth_process_source`: jlcpcb.com capabilities page |
| PTH annular ring below fabricator floor needs a documented exception | STATED (hard stop) and in review catalog `dfm.circular_pth_annular_ring` | `skills/kicad-design-review/SKILL.md`, `review/catalog.py` | | issue #1381 |
| Connector mating direction / edge alignment | catalog rule `mechanical.connector_mating_orientation`; code in `review/mechanical_acceptance.py` (not read in detail) | | | issue #1393 |
| Mains clearance / creepage | catalog rule `safety.hazardous_mains_clearance` (implementation not read) and STATED hard stop | `review/catalog.py` | | IEC 60664-1 |
| Production release requires recorded power-on bring-up with measurements | STATED and a stage gate (`review/stage_gate.py`, `mfg.bringup_evidence_verification`) | `skills/kicad-design-review/SKILL.md` | | issue #1586 |
| Never call a board fabrication-ready from edits alone; no raw text edits of KiCad files | STATED | `skills/pcb-design/SKILL.md` | | |
| Datasheet review before claiming correctness | STATED | `skills/schematic-review/SKILL.md` | | |
| BOM lifecycle / alternates | catalog rule `mfg.bom_lifecycle_alternates` (implementation not read) | `review/catalog.py`, `review/dfm_review.py` | | |

The review catalog's `source_doc` fields are mostly internal labels ("KiCad
MCP Visual QA Standard", "High-Speed Digital Design Best Practices") rather
than citable documents; IEC 60664-1 is the exception found.

#### Fabrication evidence

- README: the JLCPCB blog article of 2026-10-14 (XL4015/LM358 buck converter
  designed with Claude Code and this server) is described as "not fabricated
  or bench-tested". Issue #1314 restates that and lists the article's failures
  to reproduce (multi-unit LM358 handling, ISENSE vs ISET net confusion that
  ERC passed, duplicate Edge.Cuts on retry, 0.35 vs 0.5 mm copper-to-edge,
  feedback trace near switch node).
- `docs/evidence/reference-boards/README.md`, observation dated 2026-10-11:
  STM32F072 USB-C v1 had 3 agent attempts, **0 successful, 2 failed, 1
  infrastructure-invalid**; ESP32-C6 and RP2350 had no validated complete
  attempt. The native-live task-outcome example reports
  `insufficient_evidence` by design.
- Issue #1381 (open): an agent-built USB4085 2-layer reference board was DRC 0
  / ERC 0 / 0 unconnected yet had 16 signal PTH rings of 0.125 mm against
  JLCPCB's published 0.18 mm 2-layer minimum, and enlarging the pads would
  leave 0.09 mm between pads against a 0.10 mm minimum. Marked a manufacturing
  blocker; no evidence it was fabricated.
- No photo or statement of a fabricated, powered or tested board found.

#### Notable issues (`gh issue list ... --search "fabricated OR JLCPCB OR decoupling OR corner OR annular OR bring-up"`, 36 returned; total issue count not taken)

- #1381 above: DRC-clean board below fabricator PTH limit.
- #1582 (closed): placement findings were tied to distance only; rework so a
  nearby wrong-rail cap cannot pass and a missing pin is NOT_ASSESSED.
- #1393 (closed): connector mating direction and edge alignment were not
  validated.
- #1581 (closed): 90° corners separated from electrical correctness.
- #1380 (closed): quality-gate false positives on reference boards (placement,
  VBUS aliases, NC semantics).
- #1788 (closed): mounting holes added without keep-out or clearance.
- #124 (closed): pin-label tool stubbed side pins so that nets shorted.
- #729, #730 (open): end-to-end task success and a real-board corpus are
  still open as the project's own primary KPI.

### ProductOfAmerica/mcp-server-kicad (PyPI `mcp-server-kicad`)

- SHA `f972bfb2d340eeb6b7e5d8a95881e88059d5a494`, commit 2026-10-23; GPL-3.0
  (repo licence; PyPI says GPL-3.0-or-later); 16 stars; KiCad 9.x or 10.x.
- **Status: maintenance mode** since October 2026 (README "Why maintenance
  mode"). The authors ran plain Claude Code (no plugin) against Claude Code
  with the plugin, same model, judged by KiCad 10 netlist/ERC/DRC. Six single
  edits on a public KiCad 10 design, three runs each: plain agent 18 of 18
  right, with the plugin 3 of 18. A 20-edit session: both all right, plugin
  used about 1.8x the context. Causes they give: missing tools for some edits,
  an instruction never to edit KiCad files directly (so the model stopped and
  asked), and a board-sync tool that rewrote nearly every footprint. Test
  material unpublished (design unlicensed). Their advice: a coding agent with
  KiCad installed, checking with `kicad-cli` netlist/ERC/DRC. This is the only
  A/B measurement of an MCP server against a bare agent found in this
  workstream.
- Drives KiCad by: its own S-expression parser/writer ("CST",
  `docs/adr-cst-substrate.md`) for reads and edits; `kicad-cli` for ERC, DRC,
  exports, netlist; `pcbnew` SWIG only for `fill_zones` and `autoroute_pcb`
  (Freerouting).
- Skills: `skills/{circuit-design,pcb-layout,schematic-design,schematic-plan,using-kicad,verification}/SKILL.md`,
  agents `agents/{bom-reviewer,code-reviewer,schematic-plan-reviewer}.md`.
- Rules STATED (`skills/pcb-layout/SKILL.md` unless noted):
  - decoupling cap within 3 mm centre-to-centre of the IC
  - every IC has decoupling (`skills/circuit-design/SKILL.md`; also the
    `bom-reviewer` agent's checklist, an LLM review, not code)
  - trace width by current table, 1 oz, 10 C rise, outer layer; above 5 A
    "Use IPC-2152" (only source cited for a threshold)
  - avoid 90-degree corners; route differential pairs together, matched length
  - 4+ layers: continuous ground plane, do not split it under signals; 2-layer:
    GND trace alongside signals
  - guard ring for analog inputs; keep clocks/PWM away from analog
  - via sizes (signal 0.3/0.6 mm, power 0.4/0.8 mm, "one via ~1 A"), thermal
    via arrays of 4-9 under exposed pads
  - fab minima table ("most manufacturers", no fab named): trace/space
    0.15 mm, via drill 0.3 mm, copper-to-edge 0.3 mm
  - parts to board edge 1.0 mm (2.0 mm for wave solder)
  - derating voltage to 60-80 %, current 70-80 %; E12/E24 values; input
    protection on every external connector (`circuit-design`)
  - **datasheet use:** regulator capacitor values and divider/sense resistors
    from the datasheet, with the formula shown; "Standard 100nF decoupling is
    fine" listed as a rationalisation to reject (`circuit-design`)
- CHECKED: `validate_board` / `check_placement` (`mcp_server_kicad/pcb.py`)
  test each footprint's origin against keep-out zones and the board outline;
  the docstring says it is the origin, not the courtyard. ERC/DRC are
  KiCad's, via `kicad-cli`. Schematic read-only checks for junctions and
  no-connects that older versions wrote wrongly (#100, #101). None of the
  layout rules above is measured by code.
- Fabricated/tested: no evidence found (grep of all `.md` for
  fabricated/ordered/powered/bring-up; issues).
- Issues: 58 listed (counted by hand from the listing), all closed; they are tool-correctness bugs (footprint
  orientation vs KiCad, kicad-cli 9 cutting wires at junctions #111, labels
  merging nets silently #99, Gerber single-layer export failing on KiCad 10
  #8). None reports a board outcome.

### Huaqiu-Electronics/kicad-mcp (PyPI `kicad-mcp`)

- SHA `a2a7bf565273c629a67ddd7be4cdb273c6148b75`, commit 2026-04-20; MIT;
  26 stars. Name collision: PyPI `kicad-mcp` 0.1.6 points to this repo, not to
  lamaalrajih/kicad-mcp below.
- Drives KiCad by: JSON commands over an nng socket
  `ipc://kicad_sdk_pair-<pid>-<editor>` (`kicad_mcp/utils.py`,
  `kicad_client.py`); README says "KiCad IPC API" and "KiCad is running with
  IPC enabled". The socket name differs from KiCad's own IPC API socket
  (`api.sock`), so it appears to need a KiCad build that exposes this SDK;
  KiCad version not stated. Process discovery checks Windows executable names
  only (open issue #3, macOS).
- Tools are primitive edits (tracks, vias, pads, footprints, labels, frames).
  Rules STATED: none beyond docstrings naming IPC-2221 for reference-designator
  conventions. CHECKED: none.
- Fabricated/tested: none. Issues: 3, all open (#1 symbols cannot be placed,
  #2 startup failure, #3 macOS detection).

### lamaalrajih/kicad-mcp (the other "kicad-mcp")

- SHA `98c9ea41cb393393a8bafd157a93e84431e00afb`, commit 2025-10-17; MIT;
  537 stars; KiCad 9.0 or higher (README).
- Drives KiCad by: file parsing (netlist/schematic parsers) and `kicad-cli`
  (DRC, exports); #2 (closed 2025-03) removed `pcbnew` use.
- Read-only analysis server: project listing, BOM, netlist, DRC with history
  (`utils/drc_history.py`), and "circuit pattern recognition"
  (`utils/pattern_recognition.py`), which regex-matches component values and
  library names (regulators, op-amps, MCUs, sensors). That identifies blocks;
  it judges nothing.
- Rules STATED: MCP prompts (`kicad_mcp/prompts/*.py`) are generic requests
  ("minimum trace width and clearance settings", "component placement
  considerations"); no numbers. CHECKED: none of its own; DRC is KiCad's.
- Fabricated/tested: none. Issues: 21 listed; failures are server plumbing
  (#31 a user report that all 14 tools failed under FastMCP Context, fixed by
  an agent; #57 path-validator bypass, open; #50 netlist parser). #34 asks for
  PCB layout analysis (open).

### mixelpixx/KiCAD-MCP-Server

- SHA `aa3d834b4b9c98b47e629613287adcd939843b46`, commit 2026-11-21; MIT;
  3472 stars; KiCad 9 and 10 (README comparison table).
- Drives KiCad by: SWIG `pcbnew` from a Python subprocess under a TypeScript
  MCP server, with an experimental IPC backend; `kicad-cli` for ERC/DRC and
  exports; direct S-expression edits for schematics; Freerouting via
  Java/Docker/Podman. README v2.9.0 claims 261 tools.
- No SKILL.md. Guidance is in MCP prompts, `src/prompts/*.ts`.
- Rules STATED:
  - `routing.ts`: decoupling "close to ICs" (no number); differential pairs
    tightly coupled, consistent width/spacing, continuous reference planes, no
    splits under pairs; avoid sharp corners (45 degrees or curves); cross at
    90 degrees on adjacent layers; "Consider ground plane partitioning"
    (generic, no condition given)
  - `design.ts` `pdn_dc_review`: use IPC-2152 for a plane, IPC-2221 is for an
    isolated trace and overstates rise on a plane; 525 mA/mm (15 A/mm2 in
    35 um) marks crowding and is not a thermal limit; derive load current from
    the datasheet row with arithmetic shown; target impedance
    Z = dV_allowed / dI_step; keep the switch node small on an outer layer over
    unbroken ground; loop area is the input-cap-to-FET hot loop. Explicitly
    forbids inventing millivolts, current densities or curves. The most
    source-aware prompt found in this part.
  - `design.ts` `emc_shield_review`: no solver, do not invent field values or
    CISPR numbers; suppression in dB as 20·log10 of a field ratio; via pitch
    around a can matters; a can with few clips can be louder than none.
  - `footprint.ts`: IPC-7351 checklist, courtyard 0.25 mm around pads, THT
    drill at least lead + 0.3 mm.
- CHECKED (`src/tools/design-rules.ts`, `component.ts`, `board.ts`):
  - `audit_via_nets`: compares every via's net against a reference board or
    git revision; the description says KiCad can move a via onto another net
    on save and DRC does not flag it. Not a KiCad DRC check.
  - `check_courtyard_overlaps`: courtyard overlaps and courtyards past the
    outline, also for hypothetical positions (AABB; #406 multi-rectangle
    courtyards, closed).
  - `check_clearance`: measured clearance between two items against rules.
  - `get_stackup` with `expected`: compares the stored stackup to a recipe,
    thickness tolerance default 0.001 mm.
- APPLIED, not checked: `set_voltage_clearance_rules` writes clearance and
  creepage rules into `.kicad_dru` from a voltage table the caller supplies
  (it names IPC-2221 or IEC 60664 as the caller's choice and supplies no
  values), then KiCad DRC judges; `add_gnd_stitching_vias` places GND vias
  (grid / around refs / in zones) with collision checks;
  `python/commands/placement_optimizer.py` weights IC-to-2-pin-passive links
  (default `decoupling_boost` 2.0) so decouplers sit closest, scored by HPWL.
- Fabricated/tested: #138 (closed 2026-05-18) a user with no PCB experience
  says a board designed with Claude through this server was "ordered through
  JLCPCB and the results were..... interesting"; no photos or detail; the
  issue itself is Gerber pad coordinates in the footprint frame on rotated
  footprints. README v2.9.0: "On a real 333-pad board, 304 pads had the wrong
  net before" a `sync_schematic_to_board` fix. No board reported tested.
- Issues: 100 most recent read by title. Failures that pass KiCad's checks or
  report false success: #400 sync read backup `.kicad_sch` copies and wired
  the board from an old revision, "ERC, DRC and pad-level checks all stay
  clean"; #455 `export_gerber` wrote no files but reported every layer
  exported (SWIG); #467 same for SVG; #302 DSN export dropped all net classes
  so every net autorouted at Default width; #176 every PWR_FLAG rail merged
  into one net in `get_net_connections`; #553 `delete_trace` reported success
  over IPC but the track stayed.

### mixelpixx/Konnect (archived)

- SHA `676efce43c9779f9f9e59a9181cb0746c6452650`, commit 2026-11-02; AGPL-3.0;
  1463 stars; archived; KiCad 10.
- Why archived: README says development moved to Konnect-EDA (Orchis.ai LLC),
  closed source, free until 1.0 and free for personal/hobby/student/open-
  hardware use after, paid for businesses; AGPL releases stay available.
  #947 asks past contributors to sign off on their code moving, form open until
  2026-11-20.
- Drives KiCad by: KiCad 10 IPC API (crate `konnect-ipc`), `kicad-cli`, and
  its own S-expression parser (`konnect-sexp`) for file fallbacks; Rust.
- Skills: `crates/konnect/assets/skills/{kicad-pcb,kicad-review,kicad-schematic,kicad-library,kicad-manufacture,konnect}/SKILL.md`
  plus `references/`.
- Rules STATED:
  - decoupling within 2 mm of IC power pins, same layer
    (`kicad-pcb/SKILL.md`); cable/EMI filter caps judged against their
    connector
  - evidence hierarchy: datasheets and requirements first, KiCad ERC/DRC
    second, heuristics last; a required check that did not run makes the
    verdict INCOMPLETE (`kicad-review/SKILL.md`)
  - checklist (`kicad-review/references/design-checklist.md`): 100 nF minimum
    per IC; regulator output cap per datasheet; crystal load caps match the
    crystal spec; ADC reference decoupled; differential pairs length-matched
    (USB, Ethernet); 3 fiducials minimum
  - controlled impedance needs the fab's stackup and process
    (`kicad-pcb/references/trace-width-table.md`); fab limits from the
    fabricator's current contract, not copied numbers (`design-rules.md`)
- `kicad-review/SKILL.md` lists "Capacitor is placed close to the pin (PCB
  proximity)" under `audit_decoupling`, but the code says the opposite: the
  tool description in `crates/konnect-core/src/tools/design_review.rs` says it
  "does not inspect PCB placement distance" and the result carries
  `pcb_distance_checked: false`. The skill overstates its own check.
- CHECKED (`crates/konnect-core/src/tools/`):
  - `score_placement` (`placement.rs`): cap centre to IC courtyard-box edge,
    limit by value family: 100 nF 2.5 mm, 1 uF 5 mm, 10 uF 10 mm
    (`decoupling_limit_mm`; no source cited; differs from the skill's 2 mm).
    15 points per violation, capped at 30; a deduction, not a verdict. Hard
    fails: courtyard overlaps and parts outside a proven rectangular outline.
    Connector more than 10 mm from an edge deducts. A cap is associated with
    an IC only through a shared non-ground net of at most 8 references;
    #792 (open) reports this leaves every decoupler on an STM32F411 +3V3 rail
    "unproven", so the check cannot judge an MCU supply rail.
  - `audit_decoupling` (`design_review.rs`): each power pin (by name) must
    share a net with some capacitor; any cap on the rail passes. #903 (open):
    classification by pin name flags `3V3_EN` and misses a `power_in` pin
    named `IOVDD`.
  - `audit_power_rails`: rail has a capacitor; rail has bulk >= 10 uF.
  - `audit_manufacturing`: the board's `min_trace_width` rule against a
    per-fab table (JLCPCB 0.127, PCBWay 0.1, OSHPark 0.152 mm; comment
    "JLCPCB standard capability", no document); Edge.Cuts present;
    silkscreen over pads; dual-side assembly flagged as info. It reads the
    rule setting, not drawn track widths.
  - `audit_connections` (I2C/reset pull-ups etc.) and `check_bom_health`:
    from tool descriptions; code not read in detail.
- Fabricated/tested: #874 (closed) a 4-layer "real two-board design" built
  with agents over Konnect, reporting missing capabilities; #792 an
  end-to-end STM32F411 minimal-system build. Neither says the board was
  fabricated or tested.
- Issues: 100 most recent read by title, mostly open at archive. Failures:
  #887 `connect_pins` L-route joins any pin it passes over, shorting nets
  with no warning; #899, #900 similar for stubs and junctions; #840 DSN export
  rotates rotated footprints' pads twice; #793 `estimate_cost` prices every
  part at a flat $0.05; #951 `score_placement` hard-fails edge-mounted parts
  (castellated, flush USB-C).

### Orchis-ai-LLC/Konnect-EDA (commercial successor)

- SHA `a7000e7635a6d9529b65ecceb2c6a61b80ece995`, commit 2026-11-21; licence
  "Other" (closed source, free during beta); 186 stars; KiCad 10. The repo
  holds README, `tool-directory.md`, docs and examples only; no source.
- Drives KiCad by: KiCad 10 IPC API (NNG + protobuf) and `kicad-cli`
  (README table); no SWIG, "which KiCad 11 removes".
- Rules: `tool-directory.md` describes the same `score_placement`,
  `audit_decoupling` (now says it "does not measure PCB placement distance"),
  `audit_power_rails`, `audit_manufacturing` (adds via-in-pad, acid traps) and
  `place_decoupling_caps` (caller supplies the caps; "never discovered by
  shared nets, since GND alone pairs a cap with nearly every IC"). New:
  `add_design_rule` stores a natural-language rule for the agent (example
  given: 100 nF X7R within 3 mm) -- STATED. CHECKED status cannot be verified
  without source; counted as descriptions only.
- `docs/JLCPCB_CPL_CORRECTIONS.md`: a CPL can pass JLCPCB's structural checks
  while a part is rotated in Component Placements; a versioned rotation/offset
  correction policy is applied after export, with a provenance field. An
  assembly failure mode KiCad cannot see.
- Fabricated/tested: none stated. Issues: 4 (#5 via removal, #4 editor state
  error, #3 install scope, #1 parts database format).


## Cross-repo table

Short names used in the table:

| short name | repo |
| --- | --- |
| happy | kicad-happy |
| ixt | IxTechCrypto |
| rocco | roccoagain |
| jvdb | jvanderberg |
| flo | florianuhlemann |
| hao | haohao-0725 |
| novin | Novin3dp |
| alex | alexchunlin |
| prith | Prithvi-0g |
| azzar | 1999AZZAR |
| pro | kicad-mcp-pro |
| msk | mcp-server-kicad |
| mixel | KiCAD-MCP-Server |
| konnect | Konnect |

A threshold appears only where it was read; "cc" means centre to centre.

| rule | stated by | checked by (how) |
| --- | --- | --- |
| Decoupler near its pin | ixt (100 nF within 2.0 mm), rocco (about 2 mm or the datasheet's distance), msk (3 mm cc), konnect skill (2 mm), prith (3 mm, in an LLM prompt only), hao, mixel (no number), flo | happy DC-001 (pad to pad, MEDIUM above 5 mm, HIGH above 8 mm); flo D4 (edge to edge, over 2.0 mm is a major); alex (cc, 2.0 mm default); pro (pad to pad, 3.0 mm, warning only); konnect `score_placement` (2.5, 5 or 10 mm by value, a deduction only); jvdb (by copper path, flagged beyond 5.0 mm in the review pack); rocco measures and leaves the verdict to the agent |
| A decoupler exists for each supply pin or rail | ixt, konnect checklist, msk | rocco (schematic, `power_in` rail with no cap); flo D1–D3 (`Decouples` field per pin); alex (no cap fails); happy DC-002 (none within 10 mm); konnect `audit_decoupling` (any cap on the net) and bulk of at least 10 µF; jvdb (no reachable cap is a FAIL) |
| Pin, then cap, then via: the cap is not fed through the plane | rocco ("between the supply's arrival and the pin"), flo skill | flo D5 (a blocker: walking the tracks from the pin must reach the cap before any via) |
| Ground via at the decoupler | rocco (about 1 mm), flo (a GND via at every cap) | happy DC-003 (3.0 mm, sourced to LearnEMC); flo D7 (1.0 mm); alex (declared limit) |
| The datasheet's typical-application parts are present | rocco (layout-review: every datasheet layout requirement with its result), flo ("deep read" of the fitted vendor), msk (`circuit-design`), konnect (evidence hierarchy), pro (`schematic-review`) | jvdb `refparts.py` (each entry with its figure cited: MISSING, WRONG VALUE, FAR or AMBIGUOUS); happy DS-001 checks only that a datasheet exists |
| Differential pair skew and length | ixt (5 mil), rocco, flo (USB ±0.15 mm), msk, mixel, konnect, hao | happy DP-001 (ps per protocol, citing spec sections); pro (10 ps, warning only); jvdb (measured); novin tunes skew to 0.3 or 1.0 mm (APPLIED) |
| Continuous reference plane, no split crossing | ixt (plus a router flag keeping tracks off In1.Cu), rocco, msk, mixel | happy GP-001 (a split counts unless a cap bridging it sits within 5 mm); alex `refplane` (by signal bucket from rise time); jvdb `pour_check` (track over 0.15 mm or more of void fails) and `emc.py` (measured every 0.1 mm); pro only by proxy (a GND zone exists on the layer) |
| Ground via beside a signal via | ixt (1.0 mm), rocco (about 1.5 mm), hao (about 1 to 2 mm) | happy RP-001 (within twice the first dielectric thickness, at least 1 mm); alex `return_via` (2.0 mm for bucket 3, 1.0 mm for bucket 4); rocco and jvdb measure only |
| Stitching and pour islands | flo (about a 10 mm grid), ixt (λ/20), hao | happy (spacing against λ/20); pro (5 mm nearest-neighbour gap and a via density, warning only); jvdb `pour_check` (at least 2 vias per pour piece); alex `gnd_islands`; mixel places stitching vias (APPLIED) |
| No 90° or acute corners, stay on the 45° grid | jvdb (45° corners), msk, mixel | flo `check_track_geometry` (exits 1 with `--strict`); hao lint (off-angle segments); pro (advisory, cosmetic only); happy has none (grep) |
| Tidiness: segments per mm, jogs, one direction per layer | none | hao `kcp lint` (per-preset pass, warn and fail) |
| Pad exit angle | flo | flo `check_entry_angles` (within 45°; exits 1 with `--strict`) |
| Track width for current | rocco (IPC-2221), ixt (IPC-2152), msk, mixel (IPC-2152 for planes) | happy TW-001 (IPC-2152, with the current *estimated*); alex `feeds` and `currents` (IPC-2221, including spokes and necks); jvdb `power.py` (DC solve, measured) |
| Fab minimums | msk, ixt, rocco | rocco (JLC `.kicad_dru` packs, source dated 2026-11-05); happy `dfm.py`; pro (fab profiles, PTH ring); konnect (the rule setting, not the drawn tracks); alex `policy` |
| Read back the exported fab files | none | flo `check_fab_files` (a flash under every drill, outline, drill table); azzar `verify/` (raster clearance, keepout, netlist assertions); hao `gerber_readback` |
| Via in a pad of its own net | none | jvdb `board_lint` |
| Part sourcing: stock, lifecycle, fields | rocco, flo, ixt | jvdb (`part_gate`, `bom_check`, `partfields`); happy (lifecycle); alex `fields` |
| Netlist against declared intent | none | jvdb `netspec.py`; azzar `netlist_assert`; flo `audit_netlist`; rocco `view.py expect` |
| Connector orientation and edge | ixt | ixt (mating face points outward); azzar (connector edge rules); konnect (within 10 mm of an edge, a deduction); pro catalog (implementation not read) |
| Via nets unchanged against a reference | none | mixel `audit_via_nets` |

## Tally

I counted the rule lists in this file. The granularity varies: kicad-happy's
rows are its rule IDs, and haohao's lint metrics count one each. Read the
totals as rough.

- **CHECKED:** about 134 across the 17 repos. Three repos have none of their
  own: Huaqiu kicad-mcp, lamaalrajih/kicad-mcp and Prithvi-0g, whose checks
  are inherited from kicad-happy. Konnect-EDA's checks cannot be verified
  without its source.
- **STATED:** about 100.
- **MEASURED** (reported, no verdict): about 13, in roccoagain and jvanderberg.
- **Checks that can only warn** are counted as CHECKED. kicad-mcp-pro is the
  largest case: many of its EMC checks cannot fail.
- **Checks that measure a proxy rather than the rule they are named for** were
  found in two repos:
  - kicad-mcp-pro: "ground-plane voids", "return path", "split plane";
  - Konnect: `audit_decoupling`, which its skill says checks proximity and its
    code says does not.

## Checked rules worth noting (measure what KiCad DRC does not)

1. **Datasheet typical application, diffed against the design**
   (jvanderberg `skills/kicad-pcb-workflow/scripts/refparts.py`).
   - The agent writes `reference-parts.json` once per IC from the datasheet's
     typical-application and layout figures, with the figure cited.
   - The script names the part that satisfies each entry, or reports MISSING,
     WRONG VALUE (with tolerance) or FAR (a `max_mm` taken from the layout
     figure). It exits 1.
   - This turns "hand it the datasheets" into a pass/fail gate. It also catches
     the case where a vendor tool's BOM leaves out a part the datasheet draws:
     the script's docstring cites TPS61088, WEBENCH and the 1 µF at VOUT.
2. **The decoupler fed through the plane** (florianuhlemann
   `pcb-audit/skill/scripts/check_decoupling.py`, D5, a blocker).
   - The order of connection is checked, not only the distance. If the tracks
     from the pin reach a via before they reach the assigned cap, the cap does
     not serve that pin, however close it sits.
   - The `Decouples=<ref>:<pin>` field makes the assignment explicit, so D2 and
     D6 also catch a nearby cap on the wrong rail or the wrong cap nearest.
     kicad-mcp-pro #1582 is the same lesson learned later.
3. **Return-path rules gated by edge rate** (alexchunlin `pcbsig.py` and
   `pcbcheck.py` `refplane` and `return_via`).
   - Nets fall into buckets by the driver's rise time, from bucket 1 below
     1 MHz to bucket 4 at 500 MHz or more.
   - Reference-plane and ground-via rules fail only for buckets 3 and 4, warn
     for bucket 2, and are a cost for bucket 1.
   - This is the brief's "real only under stated conditions" in code.
4. **A split crossing with a bridge exemption** (kicad-happy GP-001, sourced
   to Hubing and Ott). A crossing does not count if a capacitor joining the two
   plane nets sits within 5 mm. Issue #39 shows the false-positive risk: every
   via larger than about 0.7 mm read as a gap.
5. **Diff-pair skew in picoseconds against each protocol's specification**
   (kicad-happy DP-001), with each limit traced to a section of the USB, IEEE
   802.3, HDMI or PCIe specification.
6. **Each pour piece tied to its plane by at least two vias, and no track over
   void** (jvanderberg `pour_check.py`). It is cheap enough to run after every
   edit.
7. **Fabrication files read back independently of KiCad.** florianuhlemann
   `check_fab_files.py` checks for a flash under every drill, which catches a
   drill-origin offset that passed DRC. 1999AZZAR `verify/` rasterises the
   Gerbers, and found 93.8 % copper under an antenna keepout that existed only
   as a drawing.
8. **A via in a pad of its own net** (jvanderberg `board_lint.py`). DRC skips
   same-net copper, and the open barrel wicks solder away.
9. **Via-net drift against a reference revision** (KiCAD-MCP-Server
   `audit_via_nets`). The board stays self-consistent, so DRC passes.
10. **Track tidiness as numbers** (haohao-0725 `kcp lint`): segments per mm,
    turns per 10 mm, jogs, and how much of each layer runs in its main
    direction. This is the only code found that scores "ugly routing". No source
    is given for its thresholds, which are presented as preferences.
11. **Pad exit angle and acute or off-grid geometry** (florianuhlemann). These
    came from a board where 27 of 41 two-pin parts had traces leaving at 60° or
    more off axis.
12. **Every check carries a planted-failure self-test** (florianuhlemann
    `--self-test`, alexchunlin's mutation bench). This is a practice, not a
    rule, but it is the only defence found against the failure 1999AZZAR
    documents: "three checkers measuring the wrong thing".

## Gaps

- **Not read:** other skill repos turned up by `gh search repos "kicad skills"`
  on 2026-11-21:
  - Milind220/Ki-Stack (23 stars);
  - HubertHQH/KiCad-skills (16, IPC API);
  - Roboworks-Automation/Kstack;
  - sabas0ba/kicad_skills, which Novin3dp names as its second-opinion reviewer;
  - seanrobertwright/lril-kicad-skills;
  - mash/kicad-skills;
  - mattkanwisher/rp2040-usbc-dev-board, a board repo built with a KiCad skill.
    It may interest workstream B.
- **Not read in detail:** some kicad-happy and kicad-mcp-pro checks are marked
  "not read in detail" in their sections. Their thresholds are not recorded.
- **Partial issue coverage:**
  - kicad-mcp-pro's issues were read through a keyword search (36 returned),
    not in full.
  - KiCAD-MCP-Server and Konnect were read by title over the 100 most recent.
  - mcp-server-kicad's issue count was taken by hand from the listing.
- **Konnect-EDA** is closed source. Its checks are recorded from tool
  descriptions only.
- **Images:** none were opened, including alexchunlin's hero GIF captioned as
  "turning on a table". I read it as a render because the same README says no
  board has been built. That is an inference.
- **Citations not followed:** IxTechCrypto's "PCBWorld-Bench, arXiv:2607.05915"
  and its model names ("Gemini 4 Argon") were not checked. Workstream D or V
  should check the arXiv ID.
- **No Reddit sources**, per the brief's Decision 1.
- **No tool was run.** Every CHECKED entry is a reading of code, not a
  demonstration that the check fires.
- **Threshold sources are mostly absent.** The exceptions:
  - kicad-happy cites Bogatin, Ott, Hubing/LearnEMC, IPC-2152, IPC-6012 and
    protocol specs;
  - roccoagain gives JLC's capability page with a read date;
  - jvanderberg's `refparts.py` makes the user cite the datasheet figure;
  - alexchunlin cites internal finding IDs.
  
  Everywhere else the numbers (2 mm, 3 mm, 5 mm decoupler limits; 1 to 2 mm
  ground vias) carry no source. Workstream E should grade them.
