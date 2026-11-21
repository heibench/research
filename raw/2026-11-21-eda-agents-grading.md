# E: grading PCB design criticisms against authoritative sources

Workstream E, sub-question 2 of `topics/eda-agents/brief.md`. Captured
2026-11-21. All sources accessed 2026-11-21.

## Method

- Each criticism is graded **REAL** (holds for ordinary boards), **CONDITIONAL**
  (holds only past a stated edge rate, frequency, current, layer count or
  geometry) or **FOLKLORE** (the authoritative sources contradict it or find no
  effect in the range where the boards in question operate).
- Sources: vendor application notes and layout guides (TI, Espressif, Renesas,
  Microchip), trade-journal articles by named practitioners with simulations or
  measurements (Bogatin, Olney, Jouppi, Fan), and an IEEE EMC Society newsletter
  column. Forum material appears only as "the common belief".
- TI PDFs were downloaded with `curl` and read with `pdftotext -layout`; quoted
  section numbers and figures come from that text. Other pages were read with a
  web fetch that returns a model-written summary of the page; those are marked
  **(summary read)** because the wording came through a summariser, not from
  the page text directly.
- Numbers in this file are copied from the source named beside them. Where I
  compute or estimate, it is labelled **estimate**.
- Not reachable (see Gaps): ADI MT-031, MT-101 and Analog Dialogue pages
  (curl: `HTTP/2 stream 1 was not closed cleanly: INTERNAL_ERROR`; fetch
  timeout), ST AN2867 (same curl error), Henry Ott's site (HTTP 403), Microchip
  AN2648 PDF (HTTP 403), Intel AN 958 mounting-inductance page (404). Ott,
  Johnson and Hartley are therefore cited only where a reachable source carries
  their work, and marked secondhand.

Short source keys used below:

| key | document |
| --- | --- |
| SPRAAR7 | TI, *High-Speed Interface Layout Guidelines*, SPRAAR7J (Nov 2018, rev. Feb 2023). https://www.ti.com/lit/pdf/spraar7 |
| SPRACP4 | TI, *Jacinto7 AM6x, TDA4x, and DRA8x High-Speed Interface Design Guidelines*, SPRACP4A (Dec 2019, rev. Jun 2024). https://www.ti.com/lit/pdf/spracp4 |
| SZZA009 | TI, *PCB Design Guidelines for Reduced EMI*, SZZA009 (Nov 1999). https://www.ti.com/lit/pdf/szza009 |
| SPRABV2 | TI, *General hardware design/BGA PCB design/BGA decoupling*, SPRABV2 (Feb 2019). https://www.ti.com/lit/pdf/sprabv2 |
| SNVA021 | TI, *AN-1149 Layout Guidelines for Switching Power Supplies*, SNVA021C (Oct 1999, rev. Apr 2013). https://www.ti.com/lit/pdf/snva021 |
| SLYT614 | C. Glaser, TI, "Five steps to a great PCB layout for a step-down converter", *Analog Applications Journal* 1Q 2015, SLYT614. https://www.ti.com/lit/pdf/slyt614 |
| SLYT512 | S. Pithadia, S. More, TI, "Grounding in mixed-signal systems demystified, Part 2", *AAJ* 2Q 2013, SLYT512. https://www.ti.com/lit/pdf/slyt512 |
| SNLA387 | L. Woodahl, TI, *Ethernet PHY PCB Design Layout Checklist*, SNLA387 (Jun 2021). https://www.ti.com/lit/pdf/snla387 |
| SNLA187 | TI, *LVDS Owner's Manual*, 4th ed., SNLA187. https://www.ti.com/lit/pdf/snla187 |
| SLVA959 | TI, *Best Practices for Board Layout of Motor Drivers*, SLVA959B (Nov 2018, rev. Oct 2021). https://www.ti.com/lit/pdf/slva959 |
| SLMA002 | S. Kummerl, TI, *PowerPAD Thermally Enhanced Package*, SLMA002H (rev. Jul 2018). https://www.ti.com/lit/pdf/slma002 |
| TUSB2E22 | TI, TUSB2E22 datasheet SNLS648C, §5.6 Switching Characteristics. https://ti.com/document-viewer/lit/html/SNLS648C/GUID-99E69C89-4597-4B9D-BDFC-025499149AD4 (summary read) |
| R01AN0628 | Renesas, *Guidelines for Full-Speed USB2.0 Board Design*, R01AN0628EJ0100 Rev.1.00 (Nov 2015). https://www.renesas.com/en/document/apn/full-speed-usb-guidelines-full-speed-usb20-board-design-rev100 |
| ESP32-HDG | Espressif, *ESP32 Hardware Design Guidelines*, "PCB Layout Design" chapter (latest). https://docs.espressif.com/projects/esp-hardware-design-guidelines/en/latest/esp32/pcb-layout-design.html (summary read) |
| MCHP-OSC | Microchip, *dsPIC33AK512MPS512 Family Data Sheet*, §2.7 "External Oscillator Layout Guidance". https://onlinedocs.microchip.com/oxy/GUID-E48B4A26-F201-4F0A-BCBA-16461582816A-en-US-4/GUID-AA04B64F-3C38-4E1C-8B51-49DE3CFE2419.html (summary read) |
| Bogatin-90 | E. Bogatin, "Should You Worry About 90-Degree Bends in Circuit Board Traces?", *Signal Integrity Journal*, 13 Apr 2021. https://www.signalintegrityjournal.com/articles/2104-should-worry-about-90-degree-bends-in-circuit-board-traces (summary read) |
| Bogatin-split | E. Bogatin, "The Case for Split Ground Planes", *Signal Integrity Journal*, 21 Feb 2023. https://signalintegrityjournal.com/articles/2982-the-case-for-split-ground-planes (summary read) |
| KB-pour | H. Kamineni, E. Bogatin, "The Role of Copper Pour and Picket Fence Vias in Digital Designs", *Signal Integrity Journal*, 17 Apr 2026. https://www.signalintegrityjournal.com/articles/4282-the-role-of-copper-pour-and-picket-fence-vias-in-digital-designs (summary read) |
| Olney-pour | B. Olney, "Beyond Design: Copper Pours in High-speed Design", I-Connect007/Design007, 14 Jun 2022. https://iconnect007.com/article/132292/beyond-design-copper-pours-in-highspeed-design/132295/design (summary read) |
| Olney-serp | B. Olney, "Beyond Design: A New Slant on Matched-Length Routing", I-Connect007, 4 Apr 2012. https://iconnect007.com/article/65583/beyond-design-a-new-slant-on-matchedlength-routing/65586/design (summary read) |
| Jouppi | M. R. Jouppi, "The New IPC-2152", *PCD&F*, 1 Jul 2009. https://pcdandf.com/pcdesign/index.php/2009-archive-articles/5305-the-new-ipc-2152 (summary read) |
| Fan | J. Fan, "Crosstalk Estimation for Stripline Traces Crossing a Split", IEEE EMC Society Newsletter Design Tips (ed. B. Archambeault), Spring 2011. https://ewh.ieee.org/soc/emcs/acstrial/newsletters/spring11/DesignTips.html (summary read) |

---

## 1. 90° trace corners

- **Grade: FOLKLORE** for signal integrity and EMI at the edge rates of
  ordinary boards; a real but small effect only for wide traces at multi-GHz.
- **Condition.** Bogatin-90 treats a corner as excess capacitance, about 1.7 fF
  per mil of line width for a 50 Ω line, and calls return loss below -15 dB
  insignificant. On that criterion a 5 mil trace shows no noticeable corner
  effect to about 70 GHz, a 20 mil trace is transparent below 25 GHz, and a
  120 mil trace starts to matter around 5 GHz (-10 dB at 10 GHz). The
  electron-radiates-from-the-tip story appears there only as a belief he reports.
- **Sources.** Bogatin-90 (the quantified one). SPRAAR7 §3.11 asks for bends
  >135° on high-speed differential pairs, with no figure for the effect.
  SLVA959 §4 (General Routing) says a 90° bend "acts as an impedance", causes
  reflection and, with switching motor phases, EMI. R01AN0628 §(USB transmission
  lines) asks for arcs or ≤135° bends on full-speed USB. Howard Johnson's EDN
  article on right-angle bends (May 2000) reaches Bogatin's conclusion, but I read
  it only through an SI-list repost summary, so it is not used as primary here.
- **Disagreements.** TI's motor-driver note (SLVA959) asserts reflection and EMI
  effects; Bogatin-90 quantifies the effect and finds it negligible below tens of
  GHz for normal widths. I weight Bogatin: it gives the mechanism, a criterion
  and numbers, while SLVA959 states the rule without evidence. The vendor 135°
  rules cost nothing to follow, so obeying them is fine; treating a 90° corner as
  a defect is not supported. Acute angles (<90°) are a different question (see
  15b).
- **Checkable from the board file?** Yes, trivially: segment-to-segment angle per
  track. Worth flagging only for nets with a declared bandwidth in the tens of GHz
  or for very wide traces; otherwise it should not be a failure.

## 2. Decoupling capacitor distance, placement order, via placement

- **Grade: REAL**, with the caveat that the physical quantity is loop inductance
  (cap-to-via trace length, via count, plane depth), and lateral distance to the
  pin is only a proxy for it.
- **Condition.** SPRABV2 §3: "Short capacitor trace length is the most important
  measure of inductance in most PCB systems. Placement in relation to the BGA is
  also important, but not as important as trace length." SPRABV2 §2: route pins
  and caps straight to the planes, and do not wire the ball to the cap before
  going to the plane. Pin-level caps cover about 1 to 250 MHz; above about
  250 MHz planar and on-die capacitance take over (SPRABV2 §1, §4). On two-layer
  boards without planes, distance is the loop: SZZA009 §2.2.4 asks for bypass
  loops "as small as possible in area and length" and a 3:1 length-to-width
  limit on bypass traces.
- **Sources.** SPRABV2 §§1–3; SZZA009 §2.1.1, §2.2.4; ESP32-HDG "Power Supply"
  (ground vias close to each decoupler's ground pad).
- **Disagreements.** The common belief that the cap must be millimetres from the
  pin is stronger than SPRABV2, which ranks trace and via length above lateral
  distance on a board with planes. Secondary sources attribute to Hubing et al.
  a finding that location can be unimportant under some conditions; I did not
  read the primary and do not use it.
- **Checkable from the board file?** Yes. Per power pin: the nearest capacitor on
  the same net pair, and the copper path length from each capacitor pad to its
  via or plane connection, plus via count. The pad-to-via length is the better
  check than pad-to-pin distance; boardwright's current check measures the
  latter.

## 3. Decoupling values ("100 nF + 10 µF everywhere")

- **Grade: CONDITIONAL.** For MCU-class parts the 100 nF + bulk default is what
  vendors recommend; criticising it there is not supported. Two narrower claims
  are real: the datasheet's own values win, and spreading several small values
  "to cover more frequencies" can do harm.
- **Condition.** SPRABV2 §2.1: with modern ceramics, inductance depends on body
  size, not value; mixed values "can resonate considerably at unpredictable
  frequencies"; TI recommends one value, 0.1–0.2 µF, in the smallest package
  manufacturable, one per two power pins (§2), and values below 0.1 µF were "not
  very useful" in TI's simulations. Bulk: at least one cap of about 15 µF or more
  per ten or so power pins (§2). ESP32-HDG: 10 µF at the supply entry with an
  optional 0.1 µF or 1 µF in parallel, 10 µF on the RF power pins 3 and 4.
  SZZA009 §2.2.4 uses 0.1 µF or 0.01 µF inside a ferrite bead and 1000 pF
  outside it.
- **Sources.** SPRABV2 §2, §2.1; ESP32-HDG "Power Supply"; SZZA009 §2.2.4.
- **Disagreements.** SZZA009 (1999) uses a mix of values and an extra 1000 pF;
  SPRABV2 (2019) says mixed small values are no longer good practice. I weight
  SPRABV2: it is newer, cites simulation and real studies, and gives the
  mechanism. The 1000 pF in SZZA009 is an EMI filter element with a ferrite,
  which is a different job.
- **Checkable from the board file?** Partly. Values and count per power pin can be
  compared against a datasheet table if one is declared; whether the values are
  right is datasheet judgment, not a geometric check.

## 4. Differential pair length / phase matching per interface

- **Grade: CONDITIONAL.** The limits differ by orders of magnitude between
  interfaces, so "unmatched pairs" is a defect only against that interface's
  budget.
- **Condition (intra-pair unless stated).**
  - USB 2.0 full-speed: R01AN0628 allows a D+/D- length difference of 2.5 mm or
    less, total length 100 mm (peripheral) or 300 mm (host). FS rise time is
    4–20 ns (TUSB2E22 §5.6, citing USB 2.0 Figs. 7-8, 7-9).
  - USB 2.0 high-speed: SPRAAR7 App. A, 50 mil skew within a pair, 4000–12000
    mil total length, at most 4 vias per trace. SPRACP4 Table 3-4: 5 ps.
  - Ethernet MDI: SNLA387 §2, matched within 20 mil for 1000BASE-T, 50 mil for
    100/10 Mb/s, total under 2000 mil; MII traces under 6000 mil, same matching.
  - MIPI CSI-2/DSI: SPRACP4 Table 3-12, intra-pair skew set by D-PHY
    mode-conversion S-parameters, "general estimate is UI / 50" (UI = 400 ps at
    1.25 GHz); lane-to-lane 40 ps (0.1 UI). SPRAAR7 App. A: CSI lane skew 40 ps.
  - USB3/PCIe/SATA/HDMI: SPRAAR7 App. A, 5 mil within a pair; SPRACP4: 1 ps for
    USB 3.1, PCIe and DP pairs; PCIe lane skew "no matching needed (de-skew built
    into receiver)" (SPRACP4).
  - LVDS: SNLA187 stresses uniform width, spacing and symmetry and low pair-to-
    pair skew for multi-pair links, but I found no numeric intra-pair limit in it.
  - Transmit and receive pairs need not match each other (SPRAAR7 §2.3).
- **Sources.** SPRAAR7 §2.3, App. A; SPRACP4 Tables 3-3, 3-4, 3-12; SNLA387 §2;
  R01AN0628; TUSB2E22.
- **Disagreements.** TI's two guides differ for USB 2.0 HS: 50 mil (SPRAAR7) vs
  5 ps (SPRACP4). Estimate: at a typical FR-4 microstrip delay of roughly
  150 ps/inch (my figure, not from these sources), 50 mil is about 7–8 ps, so
  they differ by under 2×; the 5 ps figure is for a 2019–2024 SoC family and is
  the tighter. A forum reader will be surprised how loose USB FS is (2.5 mm).
- **Checkable from the board file?** Yes: per declared pair, length of each
  member (including via barrel length if the stackup is known) and the
  difference, against a per-interface table. Lane-to-lane skew needs the lanes
  declared as a group.

## 5. Differential pair spacing / coupling and impedance control

- **Grade: CONDITIONAL.** Impedance control is real for USB HS, Ethernet MDI,
  MIPI and faster; tight coupling as such is not required by any source read.
- **Condition.** Targets: USB 2.0 90 Ω ±10% (SPRAAR7 App. A: 81/90/99 Ω;
  SPRACP4 Table 3-4); Ethernet MDI 100 Ω ±10% (SNLA387); CSI-2/DSI 85/100/115 Ω
  (SPRACP4 Table 3-12). Renesas still asks for 90 Ω ±15% on full-speed USB
  (R01AN0628). Spacing to other nets: 5W rule, e.g. 30 mil for a 6 mil trace,
  and 50 mil to clocks (SPRAAR7 §3.1); pairs at least 30 mil apart (SPRAAR7
  §3.4; SNLA387); 2–3× the pair spacing to any other trace (SPRACP4). SNLA187
  §5 defines a pair as "tightly coupled" when S < 2W and asks for uniform width
  and spacing and symmetry, not for any particular tightness.
- **Sources.** SPRAAR7 §3.1, §3.2, §3.4, App. A; SPRACP4; SNLA387; SNLA187 §5;
  R01AN0628.
- **Disagreements.** For FS USB, Renesas requires impedance control while the
  4–20 ns FS rise time (TUSB2E22) makes a few-cm trace electrically short
  (estimate, mine). Follow the vendor; do not fail a FS-only board for it.
- **Checkable from the board file?** Partly. Width, gap and gap uniformity along a
  pair, and the height to the reference plane from the stackup, can be measured;
  impedance then needs a field solver or a closed-form estimate, which is a
  deterministic calculation. Clearance to other nets is a plain geometric check
  (or a KiCad net-class rule).

## 6. Split ground planes / separate analog and digital grounds

- **Grade: FOLKLORE** as a default practice. The criticism of a split that
  signals cross is REAL (see 7).
- **Condition.** SLYT512: "It is always preferable to use only one ground plane,
  partitioning the PCB into analog and digital sections", with routing
  discipline; a split is reserved for cases such as high-resolution (≥20-bit)
  delta-sigma weighing-scale front ends, and any crossing must go over a bridge.
  Bogatin-split finds one possible benefit, a small cut in resistive-coupling
  crosstalk, measured at 2 kHz on a two-layer board (loop mutual inductance about
  0.4 nH to 0.25 nH), and lists reflections, ground bounce and EMI as the costs
  when signals cross.
- **Sources.** SLYT512; Bogatin-split; SZZA009 §2.1.7 (if splitting, keep the MCU's
  signals entirely over its own ground).
- **Disagreements.** SLYT512 notes that converter datasheets usually recommend a
  split with AGND and DGND joined at the converter, which works for one converter
  on one board and breaks down with several. ADI's MT-031 (Kester, Bryant, Byrne)
  is reported to say the same, but I could not reach it. I weight SLYT512 and
  Bogatin: both give the return-path mechanism; datasheet advice is written for
  the vendor's eval board.
- **Checkable from the board file?** Yes: count ground-net copper regions per
  layer that are not connected within a plane layer, and list signal tracks that
  cross a boundary between them (see 7).

## 7. Signals crossing a gap in the reference plane / return-path continuity

- **Grade: REAL** for anything with edge content above roughly 10 kHz, which is
  every digital edge.
- **Condition.** Bogatin-split: below about 10 kHz return current spreads by
  resistance; above it, it follows the signal path. SPRAAR7 §2.4: crossing a
  split or void forces return current around it, giving radiated emissions,
  extra delay, crosstalk and worse jitter; if a crossing is unavoidable, stitching
  capacitors of 1 µF or lower placed as close as possible to the crossing; keep
  high-speed pairs ≥1.5W from voids (§2.4, §3.2) and ≥90 mil from a plane edge
  (§3.2). Fan: in stripline with one plane split, split-related crosstalk
  dominates trace-to-trace crosstalk beyond 0.7 mm trace separation in the
  modelled case and grows with faster rise times.
- **Sources.** SPRAAR7 §2.4, §3.2; Bogatin-split; Fan; SLYT512 (bridge).
- **Disagreements.** None among the sources read.
- **Checkable from the board file?** Yes, and boardwright already does part of it:
  for each track segment, check that the adjacent plane layer has copper of the
  reference net under the full segment width plus a margin (1.5W per SPRAAR7),
  and that layer changes keep the same reference or have a stitch nearby (8).

## 8. Via stitching: spacing rules, ground vias beside signal layer changes

- **Grade: CONDITIONAL.**
- **Condition.** Beside a signal via that changes reference planes: SPRAAR7 §2.4,
  stitching vias placed symmetrically within 200 mil centre-to-centre ("closer is
  better") of the signal transition via, when the two references are both GND;
  if the reference changes net, a stitching capacitor instead. For fences and
  pours: KB-pour gives the first resonance of a via array as about
  3 GHz / d (d in inches, Dk = 4) and the guideline d < 1.5 in / BW[GHz]; for a
  30 GHz signal that is under about 50 mil. Olney-pour asks only for stitching at
  less than λ/4.
- **Sources.** SPRAAR7 §2.4 (Fig. 2-11); KB-pour; Olney-pour.
- **Disagreements.** The common belief is λ/20 (some say λ/10). I found no
  primary source that derives λ/20; KB-pour's formula is derived and gives far
  looser spacing at MCU bandwidths. Estimate from KB-pour's formula: for a
  1 GHz bandwidth, d < 1.5 in, so a board stitched every few mm is not wrong,
  just more than needed. I weight KB-pour for fences and SPRAAR7 for
  layer-change vias.
- **Checkable from the board file?** Yes. For each signal via on a declared
  fast net: distance to the nearest via on the reference net, against 200 mil
  (boardwright already checks ground vias beside signal vias). For pours: maximum
  spacing between stitching vias on each grounded copper island, against
  1.5 in / BW, with BW declared.

## 9. Ground pour on two-layer boards; floating copper islands

- **Grade: CONDITIONAL.** Connected, stitched ground fill on a two-layer board is
  helpful; floating copper is harmful at GHz; signal-layer pours over a solid
  plane on four-layer boards add little.
- **Condition.** SZZA009 §2.1.2, §2.2.3: on two-layer boards, gridding ground
  traces and fill into a network is "the most critical design technique"; fill
  "connected at only one point is just a ground shield" and contributes to the
  grid only when tied at two or more points; TI claims a two-layer board can reach
  "95% of the effectiveness" of a four-layer one this way (a claim without a
  stated measurement). ESP32-HDG: on two-layer boards keep a continuous ground
  under the chip, RF and crystal. KB-pour: "never leave any copper pour
  floating"; a floating pour forms a resonant cavity (about 3 GHz for a 1-inch
  pour) that can raise crosstalk; for 10W-spaced traces a stitched guard had no
  measurable effect, and at 5W it cut NEXT and FEXT by about 5–10 dB. Olney-pour:
  floating copper is "a real hazard for signal integrity"; pull pours back at
  least 20 mil from pairs.
- **Sources.** SZZA009 §2.1.2–2.2.3; KB-pour; Olney-pour; ESP32-HDG.
- **Disagreements.** SZZA009 (1999, two-layer, EMI) is pro-fill; KB-pour (2026,
  multilayer, crosstalk) calls pours on routing layers overrated. They answer
  different stackups, so both stand. The 95% figure is unsupported in SZZA009.
- **Checkable from the board file?** Yes: zones or fill islands with zero or one
  connection to their net (KiCad can remove unconnected islands, but does not
  report singly-connected ones); stitch-via count per island; on two-layer boards,
  the fraction of each fast signal's length with ground copper directly beneath
  on the other layer.

## 10. Trace width for current (IPC-2221 vs IPC-2152)

- **Grade: CONDITIONAL.** Real for power nets carrying amps; irrelevant for
  signals. IPC-2221's internal-layer chart is known to be far too conservative.
- **Condition.** Jouppi: the IPC-2221 internal chart was "not based on testing
  internal PCB conductors" and allows half the external current; IPC-2152 testing
  found internal and external conductors reach nearly the same rise for a given
  size and current; example given, a 100 °C rise by the old internal chart can be
  only 10 °C. Planes, board thickness and material are IPC-2152 variables; I did
  not read the standard itself. Vendor rules of thumb: SNVA021 §5, at least
  15 mil per ampere and one standard via per 200 mA for power traces; ESP32-HDG,
  main 3.3 V trace no less than 25 mil.
- **Sources.** Jouppi; SNVA021 §5; ESP32-HDG.
- **Disagreements.** IPC-2221 vs IPC-2152 on internal traces; weight IPC-2152
  (tested). Undersizing under IPC-2152 is still real; oversizing by IPC-2221 is a
  cost, not a defect.
- **Checkable from the board file?** Yes, if each power net has a declared
  current: minimum width per segment, layer, and copper weight from the stackup,
  then an IPC-2152-style or rule-of-thumb rise estimate; via count per layer
  change against current (SNVA021: one via per 200 mA).

## 11. Crystal / oscillator placement and guard rings

- **Grade: REAL** for placement close to the pins and keeping unrelated traces
  out from under and around the crystal; guard rings are vendor practice without
  a quantified effect in the sources read.
- **Condition.** MCHP-OSC: no more than 12 mm (half an inch) from the pins, same
  side as the MCU, grounded pour around the circuit tied to MCU ground, no traces
  on the opposite side under the crystal on two-sided boards, guard traces must
  return to ground. SZZA009 §2.4.1: most EMI crosstalk problems centre on the
  crystal, and no unrelated component should be closer than 1 inch to it.
  ESP32-HDG: no vias on clock traces, no high-frequency traces under the crystal,
  ground copper and stitching around the clock traces; a crystal layout fault is
  the first suspect for poor RF TX.
- **Sources.** MCHP-OSC; SZZA009 §2.3, §2.4.1; ESP32-HDG "Crystal".
- **Disagreements.** ESP32-HDG also says to keep the crystal at least 2.7 mm from
  the clock pin, which reads against "as close as possible". That is a
  chip-specific rule; follow the part's own guide. ST AN2867 would be the
  natural second source for guard rings but was unreachable.
- **Checkable from the board file?** Yes: crystal-to-MCU-pin distance; tracks or
  vias of other nets inside the crystal's courtyard plus margin on any layer;
  presence of ground copper around it.

## 12. Switching regulator layout (hot loop, feedback routing)

- **Grade: REAL.**
- **Condition.** SLYT614: the input capacitor is "the single-most important
  component" of a buck; place it first, as close to the IC as manufacturing
  allows, so parasitic inductance does not cause V = L·dI/dt spikes that can fail
  the IC; then the inductor, with the SW-node copper area minimised; route the
  sense pin (VOS) short and direct to the output capacitor. SNVA021 §2, §5: keep
  feedback away from the inductor and noisy power traces, ground the IC and
  capacitors close together to a plane, and arrange the two switching-state loops
  to circulate the same way. SNVA021 says problems show at high output current
  and large input-output differentials.
- **Sources.** SLYT614; SNVA021 §§2–5. SLYT614 also says copying the EVM or
  datasheet layout is the lowest-risk option.
- **Disagreements.** None.
- **Checkable from the board file?** Partly: input-cap pad to IC VIN/PGND pad
  distance and loop area of the (VIN cap, switch, GND) path, SW-node copper area,
  and whether the feedback track passes within some distance of the inductor or
  SW copper. Needs the regulator's pins tagged. Thresholds are part-specific, so
  a comparison against the datasheet's example layout is the honest check.

## 13. Autorouted boards being inherently bad

- **Grade: CONDITIONAL.** "Inherently" is not supported; the real point is that an
  unconstrained router does not handle power, return paths or critical nets.
- **Condition.** SZZA009 §2.6.3: autorouters "do not take any noise reduction
  actions"; route power, ground and susceptibility-critical signals by hand, then
  clocked data; only signals switching below 50 kHz can safely be left to the
  autorouter, and even those should be checked for EMI.
- **Sources.** SZZA009 §2.6.3 (1999). Trade and EDA-vendor articles (Altium,
  Cadence, In-Circuit Design columns) describe the same hybrid practice of
  routing critical nets first and locking them; I saw these only in search
  summaries, so they are not used as primary.
- **Disagreements.** SZZA009 predates constraint-driven routers; its 50 kHz line
  reflects 1999 tools. I found no authoritative measurement comparing autorouted
  and hand-routed boards.
- **Checkable from the board file?** Not as "was it autorouted". The
  consequences are checkable through 2, 4, 5, 7, 8 and 12.

## 14. Serpentines / meanders for length matching

- **Grade: CONDITIONAL.**
- **Condition.** Placement: compensate as close as possible to the mismatched end
  (SPRAAR7 §2.3, Fig. 2-5; SPRACP4 §2; SNLA387 Fig. 2-2, which says a mismatched
  placement can create timing or signal-quality issues). Self-coupling:
  Olney-serp modelled 12-inch 50 Ω traces; a closely coupled microstrip serpentine
  led a straight trace by 150 ps (about 25 ps scaled to 2 in), while a stripline
  serpentine at 5× trace-width spacing lagged by 10 ps (1.66 ps at 2 in); he
  recommends at least 5× spacing in stripline. Olney cites Johnson's simulations
  as the comparison.
- **Sources.** SPRAAR7 §2.3; SNLA387 §2; Olney-serp.
- **Disagreements.** None. The effect matters only against a ps-level budget
  (item 4); against a 2.5 mm FS-USB budget it does not.
- **Checkable from the board file?** Yes: meander gap relative to trace width,
  and the position of length compensation along a pair relative to where the
  mismatch arises (bends, pin escape).

## 15a. Teardrops

- **Grade: CONDITIONAL.** A mechanical and thermal-stress aid at thin-trace to
  through-hole-pad transitions; no source read makes them an SI or yield
  requirement in general.
- **Condition.** SLVA959 §4: teardrops reduce thermal stress at the transition,
  help avoid trace cracks, and apply when going from a small signal trace to a
  through-hole pad.
- **Sources.** SLVA959 §4. IPC-2221 annular-ring rules would be the standard
  basis but are not publicly quotable and were not read.
- **Checkable from the board file?** Yes: track-to-pad junctions where track width
  is much less than pad size, with or without teardrop fill (KiCad 7+ has
  teardrop zones).

## 15b. Acid traps (acute-angle copper)

- **Not graded.** No authoritative source reached. Fabricator and EDA-vendor
  blogs (Cadence, PCBSync) say modern photo-activated etching makes them remote
  or "historical"; I saw these through search summaries only and they are not
  authoritative. Leaning FOLKLORE for modern fabs, unconfirmed.
- **Checkable from the board file?** Yes: acute angles between joined copper
  segments of the same net.

## 16. Thermal reliefs on ground pads

- **Grade: CONDITIONAL.**
- **Condition.** Reliefs exist for soldering: they raise thermal resistance so an
  iron or reflow heats the joint (SLVA959 §2.4; SLMA002 "Installation and Use").
  For thermal pads and their vias they are wrong: SLMA002 says thermal-relief
  ("wagon wheel") construction on thermal vias is not recommended; SLVA959 §2.4
  says thermal vias must connect around the full circumference and shows the
  temperature difference (Fig. 2-3). The common belief that every ground pad
  needs a relief to avoid cold joints or tombstoning had no source among those
  read.
- **Sources.** SLMA002; SLVA959 §2.4.
- **Checkable from the board file?** Yes: zone connection style per pad and via;
  flag reliefs on exposed-pad thermal vias and high-current pads, and solid
  connections on hand-soldered through-hole pins into large planes.

## 17. Four-layer stackup choice for small digital boards

- **Grade: CONDITIONAL.** SIG-GND-PWR-SIG is a vendor-recommended stackup;
  it becomes a defect when fast signals reference the power plane or cross its
  splits.
- **Condition.** ESP32-HDG recommends exactly L1 signal, L2 unbroken GND, L3
  power with a few signals, L4 a few signals. SPRAAR7 §2.4: TI does not recommend
  high-speed signals referencing power planes; §3.12 recommends at least six
  layers for its high-speed SoCs. SZZA009 §2.1.7: avoid slots and buried traces in
  the ground plane. SPRABV2 §4: closely spaced planes (<10 mil dielectric) give
  inter-plane capacitance useful to 10+ GHz.
- **Sources.** ESP32-HDG; SPRAAR7 §2.4, §3.12; SZZA009 §2.1.7; SPRABV2 §4.
- **Disagreements.** Ott's critique of the equally spaced four-layer stackup (too
  far from return plane, too little plane capacitance) is reported secondhand via
  a Scribd copy and search summaries; I could not read it, so it is not weighed.
- **Checkable from the board file?** Yes: from the stackup and zones, which plane
  each signal layer is adjacent to; which fast nets run on L4 referencing a power
  plane; plane-to-plane dielectric thickness.

## 18. Added: via stubs on fast nets

- **Grade: CONDITIONAL** (multi-Gb/s only).
- **Condition.** SPRAAR7 §3.6–3.7: keep via stubs under 15 mil, back-drill longer
  ones; anti-pads about 30 mil (§3.8); equal via count on both members of a pair
  (§3.9). SPRACP4 Table 3-3 note: stub control "can be required when operating
  at higher data rates".
- **Checkable from the board file?** Yes, from via span vs the layers a signal
  actually uses, given the stackup.

---

## Summary

| # | criticism | grade | threshold / condition | main source |
| --- | --- | --- | --- | --- |
| 1 | 90° corners | FOLKLORE | 20 mil trace transparent <25 GHz; 120 mil matters ~5 GHz | Bogatin-90 |
| 2 | decoupler placement / vias | REAL | loop (trace + via) length matters most; distance second on plane boards | SPRABV2 §3; SZZA009 §2.2.4 |
| 3 | "100 nF + 10 µF everywhere" | CONDITIONAL | fine for MCUs; mixed small values can antiresonate; datasheet wins | SPRABV2 §2.1; ESP32-HDG |
| 4 | diff-pair length matching | CONDITIONAL | FS USB 2.5 mm; HS USB 50 mil / 5 ps; GbE 20 mil; CSI lane 40 ps | R01AN0628; SPRAAR7; SPRACP4; SNLA387 |
| 5 | diff-pair coupling / impedance | CONDITIONAL | 90 Ω ±10% USB, 100 Ω ±10% MDI; tight coupling not required | SPRAAR7; SNLA387; SNLA187 |
| 6 | split AGND/DGND as practice | FOLKLORE | single partitioned plane preferred; split only for e.g. ≥20-bit ΔΣ | SLYT512; Bogatin-split |
| 7 | crossing a reference gap | REAL | return follows signal above ~10 kHz | SPRAAR7 §2.4; Bogatin-split; Fan |
| 8 | via stitching spacing / beside layer changes | CONDITIONAL | ≤200 mil from transition via; fence d < 1.5 in / BW[GHz] | SPRAAR7 §2.4; KB-pour |
| 9 | 2-layer ground pour; floating copper | CONDITIONAL | gridded fill helps 2-layer; floating copper resonates ~3 GHz per inch | SZZA009 §2.2.3; KB-pour |
| 10 | trace width for current | CONDITIONAL | amps on power nets; IPC-2221 internal chart untested, conservative | Jouppi; SNVA021 |
| 11 | crystal placement / guard | REAL | ≤12 mm to pins; nothing unrelated within 1 in; no traces beneath | MCHP-OSC; SZZA009; ESP32-HDG |
| 12 | switcher hot loop / feedback | REAL | input cap first and closest; feedback away from inductor | SLYT614; SNVA021 |
| 13 | autorouting inherently bad | CONDITIONAL | unconstrained router on power/critical nets; "inherently" unsupported | SZZA009 §2.6.3 |
| 14 | serpentine side effects | CONDITIONAL | tight microstrip meanders lead by ps; ≥5W spacing; compensate at mismatch | Olney-serp; SPRAAR7 §2.3 |
| 15a | teardrops | CONDITIONAL | thin trace to THT pad, mechanical/thermal stress | SLVA959 §4 |
| 15b | acid traps | not graded | no authoritative source reached; leaning folklore | — |
| 16 | thermal reliefs | CONDITIONAL | never on thermal-pad vias; for solderability on THT into planes | SLMA002; SLVA959 §2.4 |
| 17 | 4-layer stackup | CONDITIONAL | SIG-GND-PWR-SIG endorsed; fast nets must not reference PWR | ESP32-HDG; SPRAAR7 §2.4 |
| 18 | via stubs (added) | CONDITIONAL | stubs >15 mil on multi-Gb/s nets | SPRAAR7 §3.6 |

Grade counts (18 rows): REAL 4, CONDITIONAL 11, FOLKLORE 2, not graded 1.

## Gaps

- **Primary texts not reached:** ADI MT-031 and MT-101, ADI Analog Dialogue
  grounding articles, ADI AN-136 (curl HTTP/2 INTERNAL_ERROR, fetch timeout;
  a second ADI CDN host was refused by this session's permission layer, so I
  stopped there); ST AN2867 (same curl error); Henry Ott's site (403); Microchip
  AN2648 (403); Intel AN 958 mounting-inductance page (404). Ott's stackup and
  split-plane positions, Johnson's EDN right-angle article and Hartley's views
  are therefore secondhand or absent.
- **IPC-2221, IPC-2152, IPC-2141** were not read; only Jouppi's description of
  IPC-2152 was. Thermal-relief and annular-ring rules in IPC-2221 are uncited.
- **Acid traps (15b)** have no authoritative source either way.
- **LVDS** intra-pair skew has no number from a source read; SNLA187 gives only
  qualitative rules.
- **Summary-read sources** (marked above) passed through a summariser; their
  numbers should be spot-checked against the page by workstream V before they
  reach `findings.md`.
- **Hubing et al. on decoupler location**, cited secondhand as finding location
  unimportant under some conditions, would sharpen item 2 if read.
