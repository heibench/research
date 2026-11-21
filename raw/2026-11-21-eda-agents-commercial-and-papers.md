# Workstream D: commercial tools, code-first tools and papers (sub-questions 6 and 7)

Captured 2026-11-21. Every source below was accessed 2026-11-21.

## Method

- Read the six arXiv papers named in the brief, abstract page first, then the
  HTML full text where the abstract did not say what the oracle was or whether
  a board was built (2611.08175, 2602.00510, 2608.31006 read in full text;
  2606.17074, 2606.19795, 2510.17002 at abstract level only).
- Searched for further papers with web search ("arXiv LLM agent PCB schematic
  placement routing 2026", "PCBWorld benchmark", "datasheet grounding ablation",
  and follow-ups). Read full text for 2607.05915, 2603.18102, 2507.10639,
  2603.15672, 2606.01188 (first 100k characters), abstract only for 2610.38201
  and 2607.03261, and venue abstract pages only for PCBInnoBench (NeurIPS 2026),
  EDA Bench (ICML 2026) and PCB Gym (NeurIPS 2026).
- Tools: read each vendor's own pages (product, docs, blog), then searched for
  an independent assessment. Copperhead's README read through `gh api
  repos/copperheadhq/copperhead/readme`. Two Hacker News threads read through
  the Algolia items API (items 49569366 and 49610059).
- Page reading was done through a fetch tool that summarises pages with a
  smaller model. Numbers below are as that summary reported them from the
  page; a figure I could only find in a search snippet or a third-party
  repost is marked **secondhand**.
- Not fetched: reddit.com (brief, Decision 1). Nothing signed up for, logged
  into or contacted.
- Model names (GPT-5.4, Opus 5.5, Claude Fable 5, GPT-6 Astra, and so on) are
  recorded as the sources name them.

## Tools

Grades for "evidence of real boards" use the brief's sub-question 5 ladder:
render only / DRC-ERC clean / fabricated / powered up / tested against
function / measured.

### Flux (Copilot and the Flux agent)

- **What the AI does (vendor claims).** Copilot reads the project's schematic,
  datasheets and connections and answers review questions: decoupling present
  and rated, pull-ups present and valued, every powered part connected to a
  source and ground; organisation rules via "Copilot Templates"; alternates
  through Mouser, DigiKey, LCSC and an Ultra Librarian partnership
  (flux.ai/p/blog/ai-design-reviews). The agent ("steerable hardware agent",
  May 2026) works out architecture, picks major parts, builds the schematic,
  documents decisions and takes mid-run steering; its examples of self-caught
  issues are missing reverse-polarity protection, floating enable pins and
  datasheet-recommended decoupling values
  (flux.ai/p/blog/new-steerable-hardware-agent). AI Auto-Layout (Nov 2025
  update) routes two- and four-layer boards from per-net-class rules, keepouts
  and hand-routed critical nets (flux.ai/p/blog/ai-auto-layout-winter-update).
- **What checks it.** None of the three pages names DRC, ERC or a simulation
  as a gate on the AI's output. Review checks are against datasheets and user
  rules, by the same model.
- **Stated limits (vendor's own).** Auto-Layout is "not designed to fully
  autoroute every class of board without your input"; expect to intervene for
  high-speed interfaces, tight length matching, thick power nets on small pads
  and strict layer reservations. Flux's FAQ says Copilot is not meant to
  auto-wire a whole schematic in one go and that complex instructions lower
  accuracy (search snippet of flux.ai/p/blog/top-9-most-asked-questions-in-flux,
  **secondhand**).
- **Boards.** Example boards on the Auto-Layout page are screenshots only;
  "4x faster convergence" has no baseline or board set. The agent page names
  no fabricated board. Grade: render only.
- **Independent assessment.** None found. A JLCPCB tutorial walks through an
  agent-built USB hub schematic (commercial interest, not independent); a
  competitor (Quilter) and a board house (AtlasPCB) characterise it as suited
  to simple two- and four-layer boards (**secondhand**, both commercial).

### Circuit Mind (ACE, AVE)

- **What the AI does (vendor claims).** ACE turns a block diagram and
  requirements into a schematic, BOM, power and derating analysis, interface
  control document and FMEA template, selecting parts and support circuitry.
  The vendor says ACE uses "deterministic, physics-based algorithms and
  validated component digital twins" rather than generative output. AVE is
  the agentic part: it reviews any schematic (including imports from Altium,
  Cadence, Siemens) for wrong pin connections, voltage violations, interface
  mismatches and missing support circuitry, and runs a self-critique pass
  before reporting (circuitmind.io; iconnect007 launch coverage).
- **What checks it.** Datasheet-derived "digital twins" and the customer's
  rules and checklists. No simulation mentioned.
- **Claims.** "Respins reduced by 30%+" with no method or baseline
  (circuitmind.io, vendor claim). Los Alamos evaluation: the vendor and press
  say a peer-reviewed LANL case study found ~90% of a medium-difficulty
  microcontroller design automated, report number LA-UR-25-30842; time figures
  differ between outlets (just over four hours vs an estimated 60 to 80 hours
  by hand; "otherwise two weeks"). **Secondhand**: an OSTI.gov search for
  LA-UR-25-30842 returned no record, and I found no copy of the report.
- **Boards.** None named. Grade: none shown.
- **Independent assessment.** None found beyond press repeating the vendor.

### atopile (and EEBench)

- **What it is.** A code-first language that compiles to a KiCad project;
  now positions itself as "a code-backed EDA platform built for agents"
  (search snippets of atopile.io and YC profile, **secondhand**). Layout and
  routing stay in KiCad: an atopile co-author on HN said atopile does not let
  you specify routing (search snippet, **secondhand**).
- **What checks it.** Its own constraint solver over parameters (tolerances,
  voltage ranges), per an EEBench team reply on HN item 49569366.
- **EEBench** (eebench.org/blog/can-ai-design-circuit-boards-yet, results
  dated 1 Sep 2026) is "built and funded by the team behind atopile". 13 V1
  tasks, analog and digital, written in atopile; graded deterministically by
  building the design and running ngspice plus design checks, cost scored
  against a reference BOM only for working circuits. Top scores read: Claude
  Opus 5 61.6%, Grok 4.6 57.1%, Claude Fable 5.1 56.4%, Claude Fable 5 54.3%,
  Claude Opus 4.8 Max 51.4%. V1 covers no layout, manufacturing or bring-up.
  The authors state atopile worked much better for them than having a model
  draw in a GUI, with no controlled comparison: **opinion**.
- **Boards.** One public anecdote: an ESP32-S3 board vibe-coded with atopile
  and Claude (atomic14 substack, 12 Jul 2025). Errors the author caught:
  nothing wired at first, EN-pin RC missing its capacitor, a 330 Ω where 10 kΩ
  was wanted; ground fills and tidying done by hand. Not fabricated. Grade:
  render only.

### tscircuit

- **What it is.** A TypeScript/React code-first EDA with its own autorouter
  in development; the repo README mentions AI only as "your favorite editor and
  AI coding tools" and text-to-footprint generation (github.com/tscircuit/tscircuit).
  No DRC mentioned on that page.
- **What checks it.** tscircuit/prompt-benchmarks scores LLM-written circuits
  with an LLM scorer (0 to 1 on correctness, component use, complexity, code
  quality) plus `@tscircuit/eval` (search snippet of the repo README,
  **secondhand**). An LLM grader is not an oracle independent of the method.
- **Boards.** The README shows manufactured boards (e.g. an RP2040 motor
  controller) but does not say any were AI-designed. No AI-made board found.
- **Independent assessment.** HN opinions only (one user found the code
  repetitive; one uses it for agent-driven design), **secondhand** snippets.

### Copperhead and copperbench.org

- **Copperhead** (github.com/copperheadhq/copperhead, README read 2026-11-21;
  v0.10.0 August 2026 per a listing site, **secondhand**). An agent that edits
  `.kicad_sch`/`.kicad_pcb` s-expressions, keeps Markdown design docs as
  memory, and runs `kicad-cli` ERC/DRC after every mutation, rolling back in a
  git snapshot if verification fails. Edits are refused until a validated
  change proposal exists ("spec-gated"). `copperhead check` (ERC + DRC + doc
  drift) calls no LLM. It states it is not an autorouter, not the engineer of
  record, and never claims fab-ready beyond "ERC/DRC clean". Its own maturity
  section says the agent loop's acceptance tests "have not been observed
  passing end to end". On Show HN (item 49610059, 8 Sep 2026) a maintainer
  reply said Copperhead works on its own IR that compiles to KiCad files,
  which differs from the README's "reads and edits real files"; recorded as
  found, not resolved.
  - What checks it: KiCad's engine only. No simulation ("stay tuned" on HN).
  - Boards: none. Grade: DRC-ERC clean is its ceiling by its own statement.
- **copperbench.org** (read 2026-11-21). Benchmark for agents editing KiCad
  projects on pinned open-hardware boards; graded offline with `kicad-cli` and
  fixed assertions, "never involves a model"; each task proven by a no-op run
  that must fail and a reference run that must pass. Same organisation as
  Copperhead (both under chouhanindustries / Chouhan Industries). State on
  the capture date: 1 simple and 1 medium task, 0 hard, 0 variants, agent mode
  not implemented, no model results. Established nothing about agents yet; its
  oracle design (no-op must fail, reference must pass, LLM-free grading) is the
  one worth copying.

### Quilter

- **What the AI does (vendor claims).** Placement and routing only, by a
  "physics-driven" reinforcement-learning system, not a language model; it
  returns several ranked candidates. Its docs say it does not do schematic
  updates, footprints, stack-ups or design rules, does not proofread
  schematics, and does not review datasheets for floating pins or missing
  bypass capacitors (docs.quilter.ai/about-quilter/what-quilter-isnt).
- **What checks it.** Its own "Physics Rule Checks" against constraints the
  user declares. The docs recommend the user run DRC, schematic review, signal
  simulation and fabrication testing themselves.
- **Evidence of a real board: Project Speedrun** (quilter.ai/project-speedrun;
  validation post quilter.ai/blog/validating-an-ai-designed-computer-running-under-real-workloads,
  dated 10 Dec 2025). Two-board i.MX 8M Mini Linux computer, 843 components,
  5,141 pins, 8-layer HDI, fabricated and assembled by Sierra Circuits. Vendor
  figures: 27 h Quilter runtime, 98% routing completion, 38.5 h human cleanup
  (PDN pours, via clusters, minor footprint swaps) against 428 h quoted by
  layout services (a quote, not a measurement), "no rip-ups and no respins".
  Bring-up: Linux booted, LPDDR4 trained at 3 GT/s, camera, 1080p display,
  Gigabit Ethernet, USB exercised under load. Thermal, power-rail, SI/eye and
  EMI characterisation are listed as future work; no measured values given.
  The schematic was human-prepared and based on NXP's reference platform; the
  page does not say Quilter touched it. Grade: tested against function
  (vendor-run), not measured.
- **Independent assessment.** Elektor (3 Nov 2026,
  elektormagazine.com/news/ai-pcb-layout-quilter): an Elektor engineer's
  on-screen demo placed two SMA connectors too close for both to take cables
  and put the MCU in a corner he would not have chosen; conclusion that an
  engineer must still check connector clearance and mechanical fit. Not
  fabricated. This is the only non-vendor hands-on assessment found for any
  tool in this section.

### JITX

- Code-first design (moving from its own DSL to Python, per a profile dated
  June 2026, **secondhand**) where the engine selects parts, places, routes and
  checks against electrical, mechanical and manufacturing rules; AI writes and
  debugs design code. Vendor-reported via IEEE Spectrum: boards "three times
  as fast and 25 percent cheaper" than unassisted experts (**secondhand**,
  vendor claim). No board evidence or independent assessment read.

### Diode Computers (Zener) and the Anthropic collaboration

- Zener: a Starlark-based schematic-as-code language with an MIT-licensed
  toolchain over KiCad (search snippets, **secondhand**).
- Anthropic article, 12 Dec 2025
  (claude.com/resources/articles/making-claude-a-better-electrical-engineer):
  Claude given a chip's documentation produces a configurable Zener reference
  design, with file tools, the Zener compiler, docs and a few examples. Graded
  by a custom testbench checking requirements (e.g. "at least 22uF between
  power and ground"), plus blind preference by Diode engineers: Sonnet 4.5
  preferred over Opus 4 60/40 and over Sonnet 4 82/18 (chart); text says 8 of
  10. Failure modes named: missing datasheet nuances on configuration,
  misreading reference-schematic images, misusing Zener. No with/without
  datasheet comparison; no board described. Vendor-of-model source.
- PCB Gym (NeurIPS 2026 abstract, below) supplies design intent in Zener.

### Cadence (Allegro X AI, AuraStack), Siemens (Fuse EDA AI Agent), Altium

- **Cadence Allegro X AI** (announced Apr 2023): automated placement, metal
  pour and critical-net routing for small-to-medium designs with SI/PI
  analysis "built in"; claims 10x or more turnaround reduction; a customer
  quote says placement went from days to minutes (vendor claims, read via
  search snippets and press, **secondhand**). AuraStack AI Super Agent for PCB
  and packaging announced 16 Jul 2026, availability "in 2026" (**secondhand**).
- **Siemens Fuse EDA AI Agent** (news.siemens.com, 16 Mar 2026): "aids
  layout, signal integrity and other analyses in Xpedition and HyperLynx";
  the only PCB check named is SI analysis; no quantified results (vendor).
- **Altium**: release notes 26.6 to 26.11 searched; no AI agent feature
  found. Scope: one web search, not exhaustive.
- None of the three offered a fabricated-board result or an independent
  assessment that I found.

### OpenAI GPT-6 Astra KiCad demo (as tested by JLCPCB)

- JLCPCB blog (14 Sep 2026, updated 10 Nov 2026,
  jlcpcb.com/blog/gpt-6-astra-pcb-design-in-kicad): OpenAI's own clip is 15 s
  of layout in KiCad starting from an existing schematic. JLCPCB's run built a
  TPA3116D2 amplifier schematic, checked 120 pin-pad pairs against datasheets,
  placed parts, exported fab files. ERC/DRC reported 0 violations **with nine
  check categories disabled**; 46 schematic-parity issues on first check;
  routing reused from an earlier task, so Astra did not route it. Not
  fabricated. Board-house source, commercial interest. Grade: DRC-ERC clean
  (with checks disabled).

### AllSpice DRCY

Listed under papers (2603.15672): a deployed schematic-review agent with no
accuracy evaluation published.

### Not read

DeepPCB (InstaDeep) appeared in comparisons but I read no primary source.
Circuitron (github Shaurya-Sethi/circuitron, SKiDL agent) seen only as the
baseline PCBSchemaGen beats.

## Papers

### 2611.08175 PCBRouteAgent (Zhang, Sun, Jing, Wei, Yang; v1 5 Nov 2026)

- **Established:** an LLM planner on top of KiCad's own router clean-passes
  more real open-source boards than Freerouting, RL policies or LLM agents
  driving the engine move by move, but still fails 60% of large boards, and
  clean pass says nothing about electrical intent (its USB case routed D+ and
  D- independently, not as a pair).
- Benchmark: PCBWorld-Bench, 247 boards (D2 synthetic 128; D3-A 99, D3-B 10,
  D3-C 10 real open-source boards). Clean pass = all connections complete and
  zero error-level KiCad DRC violations.
- Results (Opus 5.5): CP D2 1.000, D3-A 0.949, D3-B 1.000, D3-C 0.400.
  Best baselines: D3-A 0.810 (PPO), D3-B 0.640 and D3-C 0.300 (Freerouting).
  Ablation without the LLM planner: 0.961 / 0.535 / 0.000 / 0.000. Wirelength
  on D3-B 10.9% longer than Freerouting; on D2 4.2% shorter with 19.7% fewer
  vias.
- Oracle independent of method: partly. KiCad DRC is an engine the agent
  also calls; it is not the authors' code, but the agent optimises against it.
  D3-B result includes retries of unscored model failures and angle repair.
- Fabricated or measured: no. No SI analysis.

### 2602.00510 PCBSchemaGen (Zou, Han, Nazerian, Zhang, Guo, Huang; v1 31 Jan 2026, v2 17 Jun 2026)

- **Established:** grounding a frozen LLM in a datasheet-derived schema
  (pin roles and constraints per IC) is the largest single factor in passing
  its schematic verifier: 26.8% overall with no grounding, 77.6% with
  component-only grounding, 81.3% with the full schema (62-task PCBBench,
  930 trials, Gemma-4-31B). Pin-level verifier feedback adds about as much
  as grounding (57.7% binary feedback vs 81.3% pin-level).
- Output is SKiDL Python compiled to KiCad schematic/netlist/PCB.
- Benchmark: 227 real-IC tasks, 22 domains, 2 benchmarks; one derived from
  public schematics as held-out.
- Oracle: a deterministic 5-layer verifier (ERC; pin-role compatibility;
  subcategory templates; topology signatures by subgraph isomorphism against
  vendor-derived templates; power invariants). **Not independent**: the same
  verifier supplies the refinement reward and defines pass. Partial
  independent check: on 300 stratified samples, agreement with blind senior
  PCB engineer labels κ = 0.91, false accept 6.7% (95% CI 3.7 to 11.8),
  false reject 2.7%.
- Other ablations: no refinement Pass@4 60.54 vs 81.29 with Thompson
  sampling; binary reward 72.7 vs 78.0; no in-context exemplars 72.0 vs 78.0.
- Fabricated: the paper shows one fabricated 5000 W AC-DC converter prototype
  (Figure 5) as a demonstration; no measurements in the part read. Section
  after the first 100k characters (appendix) not read.

### 2606.17074 GenAI in PCB design and test survey (Srinivasan, Turnbull, Pearce; 10 Jun 2026)

- **Established (abstract only):** the authors find PCB design underexplored
  next to IC/HDL generation and name data scarcity and weak integration with
  existing PCB tools as the main obstacles. Survey; no oracle, no board.
  Full text not read; datasheet grounding and code-first coverage unknown.

### 2606.19795 Agentic EDA: a handoff perspective (Liu, Han, Lu, Zheng, Yan, Yu; v1 18 Jun 2026)

- **Established (abstract only):** a taxonomy of 115 LLM-agent EDA systems
  by where they sit relative to stage handoffs (intra-, inter-, extra-stage).
  Survey; no experiments, no oracle, no board. Mostly IC-oriented by the
  abstract; PCB coverage not checked.

### 2608.31006 From prompt to prototype: LLM-driven RF workflow (Heinrichs, Moschner, Tewes, Wienstroer, Sezgin, Kronberger; 31 Aug 2026)

- **Established:** one engineer supervising Claude Fable 5 in Claude Code,
  scripting CST, ADS and KiCad, produced a simulated active GNSS L1 antenna
  (patch + SAW + two-stage LNA) that passes ERC/DRC under the fab's rules;
  the engineer still caught errors the agent did not: an unreadable
  net-label-only schematic, a junction simulated as a crossing but routed as
  a tee, rounded line ends, a 90° feed corner (mitred to 45°), a short
  solder-mask opening.
- Results are simulation only: antenna 5.15 dBic, AR 2.46 dB, S11 -22.6 dB;
  LNA 36.9 dB gain, 0.77 dB NF; system 35.5 dB gain, 1.69 dB NF.
- The agent found two of its own errors (a bias point over the transistor's
  2.25 V VCEO limit; a stalled axial-ratio search). It read the transistor
  datasheet mid-design; the paper says all further knowledge came from the
  model, besides two Markdown files on the CST and ADS APIs.
- Oracle: commercial EM and circuit simulators plus KiCad ERC/DRC, and an
  automated schematic-vs-layout-vs-simulation check over 75 nodes and 18 nets.
  Independent of the model, chosen by the authors.
- Fabricated or measured: no; "prototype is pending fabrication and
  measurement".

### 2510.17002 EEschematic (Liu, Chitnis; 19 Oct 2025)

- **Established (abstract only):** a multimodal LLM with six few-shot analog
  substructures and visual chain-of-thought turns SPICE netlists into readable
  schematics for three small circuits (inverter, 5T-OTA, telescopic cascode).
  Oracle not stated in the abstract; no numbers; no board. IC-level analog
  schematics, not PCB.

### 2607.05915 PCBWorld (Song et al., LG AI Research; v2 3 Aug 2026)

- **Established:** an LLM routing agent that sees KiCad's DRC after every
  step beats the same model planning open-loop, by a wide margin: GPT-5.4 on
  D3-A clean pass 0.65 interactive, 0.19 plan-and-execute, 0.02 engine-free
  (DRV 1.31 / 16.28 / 34.58). The ordering holds on D2 and across GPT sizes.
  All LLM agents score 0.00 on D3-B; Freerouting 0.80 D3-A, 0.78 D3-B.
- Oracle: KiCad DRC API (38 checks) plus connectivity; wirelength and vias
  as cost proxies. Engine is independent code but also the agent's feedback.
- No fabrication, no SI.

### 2603.18102 HWE-Bench (Qiu, Xiao, Pan; 18 Mar 2026)

- **Established:** given requirements and the component datasheets, the best
  model produced a fully correct board-level schematic 8.15% of the time
  (Claude Sonnet 4.5; GPT-5.2 6.58%, Gemini 3.1 Pro 5.16%), on 300 tasks.
- Oracle: static rule checks plus LTspice transient simulation against an
  expert-built ground-truth circuit (pass = no damage, key node values within
  thresholds). Independent of the models. Authors note one reference can
  penalise valid alternatives.
- Datasheets always supplied; no with/without ablation. A text claim
  (dynamic pass rate higher than static) contradicts its own tables.
- No board.

### 2507.10639 Evaluating LLM workflows for SMPS design (Nau, Krummenauer, Zimmermann; v2 7 Nov 2025)

- **Established:** on 269 switched-mode power supply tasks, simulation
  feedback improved solve rate far more than retrieval over datasheets:
  o3 alone 25.4%, o3 + RAG 44.1%, o3 + SPICE 84.9%, o3 + RAG + SPICE 90.7%;
  GPT-4o 14.4% / 16.1% / 46.4% / 48.7%.
- Oracle: features extracted from LTspice simulation of the result, within
  ~5% of target; component choices compared with brute-force search.
  Independent of the LLM, though SPICE is also the feedback tool in the
  SPICE arms.
- No hardware built.

### 2603.15672 DRCY (Dumont, Herbert, Tirmazi, Upadhayaya, AllSpice; 13 Mar 2026)

- **Established:** a description of a deployed agent that checks schematic
  connections pin by pin against datasheet-extracted specs, with a critic
  agent scoring extractions; no accuracy, recall or false-positive figures,
  no ablation. Production use and "under 20 minutes for a 10-page schematic"
  are vendor claims. A demo used deliberately seeded errors with no detection
  results reported.

### 2606.01188 pcbGPT (King, Kehrberg, Beigl, Röddiger; 31 May 2026)

- **Established:** a Python-DSL schematic generator with library search,
  datasheet-grounded knowledge, execution and ERC checks and an LLM validator
  reaches pass@1 0.90 (GPT-5.3-Codex) on 20 embedded tasks, falling to 0.72
  on hard ones; the commonest failure is wrong or missing supporting
  components (68 of 115 failed runs), then wrong interface connections (46).
- Oracle: deterministic comparator against reference circuits, separate from
  the in-loop checks; agreement with human labels 97.5%, κ 0.941 over 400
  runs. Independent of the generation loop.
- No ablation of grounding or of the DSL; a qualitative DSL-vs-SKiDL
  comparison only. No board; the paper says electrical correctness is not
  established.

### 2610.38201 Natural language to power-electronics schematics (Su et al.; 28 Oct 2026)

- **Established (abstract only):** a framework using distributor APIs,
  datasheets and closed-loop ngspice beats a vanilla LLM on component
  verification coverage (22.2 to 98.6), nominal value consistency (0 to 97.7)
  and SPICE pass (0 to 100), over two case studies (buck, DAB). The baseline
  setup and units are not given on the abstract page. No hardware.
  The "4/18 positions" figure appeared only in a search snippet
  (**secondhand**).

### 2607.03261 OmniLayout (Lu et al.; v3 27 Sep 2026)

- **Established (abstract only):** on 1,681 schematic-coupled layouts
  (77.24K placement instances), current LLMs show weak geometric reasoning,
  poor routability optimisation and inconsistent preservation of connectivity.
  Oracle not given on the abstract page. No board.

### PCBInnoBench (NeurIPS 2026 poster, Xia et al.; venue abstract only)

- **Established:** on 372 expert-designed KiCad edit tasks from real
  projects, the best agent passes 22.0% at Pass@1 when given an expert edit
  trajectory and references, 7.3% given the goal alone. Hidden ground-truth
  design and expert-reviewed validators. No board.

### EDA Bench (ICML 2026, Saini; venue abstract only)

- **Established:** on 35 KiCad reconstruction tasks from open hardware, the
  best web-enabled harness scores 4.58% on external electrical behaviour
  while building 21 of 35 projects: parseable, plausible boards that do not
  function. Oracle extracts routed copper, models trace parasitics and
  shorts, runs ngspice and KiCad ERC/DRC; validated by all 35 references
  scoring 1.0 and structural-failure canaries scoring at most 0.15.
  Independent of the agents. No fabrication.

### PCB Gym (NeurIPS 2026, Chen; venue abstract only)

- **Established:** frontier LLMs produce DRC-valid, fully routed boards on
  32.1% of joint placement-and-routing attempts on 2- to 12-layer open
  designs, and commonly route power rails like signals. Intent supplied in
  Zener; graded by deterministic checks plus a rubric-based agentic grader
  (the latter not independent of LLM judgement). No board.

### PCB-Bench (ICLR 2026, Li et al.)

- Read only through search snippets (**secondhand**): ~3,700 text QA, ~500
  multimodal problems, 174 real projects, zero-shot; reports large gaps in
  spatial and constraint reasoning. No numbers read. Not graded as a finding.

## Method evidence (sub-question 6)

Grades: **ablation** (same system with one factor removed), **comparison**
(different systems or conditions, more than one factor differs),
**anecdote** (single case), **opinion**.

### Grounding in datasheets, reference designs, app notes

| evidence | grade | what it shows | caveat |
| --- | --- | --- | --- |
| PCBSchemaGen KG ablation, 2602.00510 Table 5 | ablation | datasheet-derived schema: 26.8% → 81.3% verifier pass; component-only grounding already 77.6% | verifier is also the in-loop reward; κ 0.91 vs experts on 300 samples; schematic only, Gemma-4-31B only |
| SMPS workflows, 2507.10639 | ablation | RAG over datasheets: o3 25.4% → 44.1%, GPT-4o 14.4% → 16.1%; SPICE feedback: o3 → 84.9%; both → 90.7% | simulation-scored, power supplies only; grounding helps a reasoning model much more than a non-reasoning one; closed-loop checking helps more than grounding |
| PCBInnoBench guided vs goal-only | comparison | expert trajectory + references: 22.0% vs 7.3% Pass@1 | trajectory and references given together; venue abstract only |
| Power-electronics framework vs vanilla LLM, 2610.38201 | comparison | grounded pipeline 98.6 vs 22.2 component verification coverage | many factors differ; two case studies; abstract only |
| pcbGPT, 2606.01188 | none (no ablation) | grounded pipeline reaches 0.90 pass@1 | does not isolate grounding |
| HWE-Bench, 2603.18102 | none | with datasheets always supplied, best is 8.15% fully correct | shows datasheets alone are far from sufficient; no without-datasheet arm |
| Anthropic/Diode Zener reference designs | anecdote | failure modes include missing datasheet configuration nuances and misreading reference-schematic images | no with/without arm |
| RF workflow, 2608.31006 | anecdote | agent read one datasheet mid-design and caught its own VCEO violation; engineer caught layout errors | one design, not fabricated |
| Flux, Circuit Mind, DRCY claims | opinion (vendor) | datasheet-grounded review catches decoupling, pin and voltage errors | no accuracy figures published |

No source found tests "research parts before the schematic" as a separate
step.

### Closed-loop engine checking (relevant to "drive KiCad and read its verdict")

| evidence | grade | what it shows |
| --- | --- | --- |
| PCBWorld Table 4, 2607.05915 | ablation | same model, same tasks: interactive with KiCad DRC every step 0.65 CP; plan-then-execute 0.19; no engine 0.02 |
| PCBRouteAgent "w/o LLM", 2611.08175 | ablation | LLM planner over KiCad's router lifts D3-B 0.000 → 1.000, D3-C 0.000 → 0.400 |
| PCBSchemaGen feedback granularity | ablation | binary feedback 57.7 → pin-level 81.3 |
| SMPS SPICE arm, 2507.10639 | ablation | simulation feedback is the largest single gain in that study |

### Code-first (atopile, tscircuit, SKiDL, Zener, Python DSL) vs driving KiCad directly

| evidence | grade | what it shows |
| --- | --- | --- |
| None found | — | No paper or benchmark compares a code-first representation with direct KiCad editing on the same tasks and model. |
| PCBSchemaGen (SKiDL), pcbGPT (Python DSL), EEBench (atopile), PCB Gym (Zener) | design choice | four evaluations chose code-first input or output; none ablates it. pcbGPT gives a qualitative DSL vs SKiDL table only. |
| EEBench authors | opinion | atopile "worked much better" than a model drawing in a GUI; vendor-affiliated (built by the atopile team) |
| HN item 49610059 | opinion / anecdote | one commenter recommends SKiDL → netlist → KiCad review; another made two boards with Claude generating KiCad sources from a shared netlist via a Python script, validated by `kicad-cli`, fabricated at PCBWay, reported working (no evidence attached) |
| HN snippet on atopile thread | opinion | atopile does not express routing; layout still done in KiCad (**secondhand**) |

Reading across all of it: the measurable gains come from (1) giving the
model structured, pin-level facts from datasheets and (2) closing the loop on
an independent engine (KiCad DRC, SPICE) with fine-grained feedback. Both
have ablations; both were measured on schematic or routing correctness, never
on a fabricated board. Whether the design lives in code or in KiCad files has
no controlled evidence either way, and every code-first system above still
hands layout to KiCad.

## Gaps

- No source tests datasheet grounding or code-first representation against
  a fabricated or measured board. The only fabricated boards in this
  workstream are Quilter's Speedrun (layout only, vendor-run functional
  bring-up, no measurements) and one PCBSchemaGen demonstration converter
  (not characterised in the part read).
- No independent (non-vendor) assessment found for Flux, Circuit Mind,
  atopile, tscircuit, JITX, Cadence, Siemens or Copperhead. Elektor's Quilter
  demo is the only one, and it is on-screen.
- The LANL report behind Circuit Mind's headline claim was not found on
  OSTI.gov under LA-UR-25-30842.
- Abstract-only reads: 2606.17074, 2606.19795, 2510.17002, 2610.38201,
  2607.03261, PCBInnoBench, EDA Bench, PCB Gym. PCB-Bench snippets only.
  PCBSchemaGen and pcbGPT read to 100k characters; appendices unread.
- Quilter's EMI post ("Part 7") is linked from Speedrun but was not found or
  read.
- DeepPCB, Circuitron and Altium's AI features were not read from a primary
  source.
- Reddit not consulted (brief, Decision 1).
- All page reads went through a summarising fetch tool; workstream V should
  re-derive the PCBSchemaGen Table 5, PCBWorld Table 4 and SMPS figures from
  the papers directly before they reach `findings.md`.
