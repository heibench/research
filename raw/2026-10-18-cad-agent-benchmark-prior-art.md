## Prior art: LLM-agent CAD / CAD-as-code benchmarks

Ranked by relevance to "does a machine-checkable verification tool produce better CAD, and at what token cost?" Everything 2605–2609 is a 2026 arXiv preprint; I verified each by fetching the paper/repo rather than trusting search summaries.

---

### Tier 1 — papers that actually toggle a verification tool

**1. CADTestBench / "Text-to-CAD Evaluation with CADTests"** — https://arxiv.org/abs/2605.07807 · https://github.com/dimitrismallis/CADTestBench · https://huggingface.co/datasets/dimitrismallis/CADTestBench
NeurIPS 2026. Repo released 2026-05-08, last touched 2026-05-22. **The closest existing thing to the question.**
- Task: text prompt → CadQuery program. Two prompt styles (abstract / detailed).
- **Oracle: genuinely machine-checkable.** 5,937 executable Python tests (~15 per sample) querying the B-rep through CadQuery: solid/shell validity, face/edge/vertex counts, geometry types, bounding boxes, wall thickness, volume, centre of mass, symmetry. Plus 1,275 CAD mutants for test-suite validation. Tests are LLM-authored (Claude planner) refined over 4 rounds, not hand-written; human agreement checked on 125 pairs, κ = 0.54 (moderate — a real weakness).
- 200 samples, derived from CADPrompt. Public.
- **Tool-assistance: yes, explicitly.** Table 3 (Claude Sonnet): ReAct 0.580 → CADTests 0.590 → CADTests+Log 0.625 (detailed prompts); 0.715 → 0.765 → 0.810 (abstract). So +4.5 / +9.5 points from handing the agent the checker.
- **Cost: none.** No tokens, no iteration counts, no dollars. States only that visual feedback "significantly increases token usage" and that it picked Sonnet over Opus for cost — no numbers.
- Contamination: not analysed. Built on CADPrompt → DeepCAD, public since 2021.

**2. MAC (Multi-Agent CAD)** — https://github.com/Pan-Chera/Multi-Agent-CAD · MIT · 1,041 stars · pushed 2026-10-17
**The only public artifact that puts tokens, dollars and verification condition in one table.** build123d-based, not a paper.
| Workflow | In-loop verification | Tokens | Est. cost | Feature pass |
|---|---|---:|---:|---:|
| CAD Skill reproduction | — | 103.95M | $18.59 | 97.9% |
| CAD Skill reproduction | Visual | 87.46M | $29.45 | 93.6% |
| MAC v1 | Geometric | 0.90M | $1.43 | 99.3% |
| MAC v2 | Visual + geometric | 1.40M | $4.85 | 99.3% |
- **But it is not a clean ablation**: the no-verification arm is a *reproduction of a different system*, so workflow architecture and verification condition are confounded. 10 prompts / 141 features, self-reported, no external oracle (features scored by the project). Prompts originate from `earthtojake/text-to-cad`.
- Still the single most useful precedent for how to present the result — and its headline (geometric verification raised pass rate *while cutting tokens 116×*) is the hypothesis worth testing properly.

**3. Hephaestus / "Self-Improving CAD Generation Agents with FEA as Feedback"** — https://arxiv.org/abs/2605.17448 · CC BY-SA 4.0
Three separable tools ablated independently (21-view renderer, blueprint stage, FEA retry loop) on H-CCX (50 cases) + S2O (133) + Fusion360 (225).
- Oracle: FEA against typed requirements, plus Box-IoU vs reference.
- Deltas: FEA retry +13.4 mean requirement points (range −1.3 to +30.9); renderer-only lifted GPT-5.5 Box-IoU 0.444→0.581 on S2O; blueprint-only 0.444→0.592. Combined loop 38.8%→60.5%.
- **Cost: wall-clock only** — ~10 min → ~68 min per item (~7×). No tokens, no dollars, no turn counts.
- Notably strict: across 400 FEA-revised submissions only **one** extra strict pass. Partial credit moved; actual correctness barely did.
- Only paper that discusses leakage honestly — acknowledges the agent re-reads target requirements during repair, argues engineers have them too, keeps canonical checkers hidden.

**4. CADSmith** — https://www.alphaxiv.org/abs/2603.26512 · https://github.com/jabarkle/CADSmith
100 prompts, 3 tiers. Oracle = exact OpenCASCADE measurements (bbox, volume, validity) feeding a correction loop + a VLM judge on 3-view renders. Zero-shot → full loop: exec 95%→100%, median IoU ~0.81→0.96, mean Chamfer 28.37→0.74. Ablates removing the *renders* (35× T3 degradation) but **not** removing the kernel-metric check alone. No cost reporting. License unstated.

**5. CADCodeVerify + CADPrompt** — https://arxiv.org/abs/2410.05340 · https://github.com/Kamel773/CAD_Code_Generation
Oct 2024 / ICLR 2025, Georgia Tech. The ancestor of this whole line and the source of CADPrompt (200 objects, CadQuery, from DeepCAD).
- **Important caveat for your framing: it is *not* a machine-checkable tool.** It is VLM self-questioning — the model writes 2–5 yes/no questions and answers them from four renders. The paper's actual geometric solver baseline *requires the ground-truth mesh*, so they correctly label it an upper bound, not a usable tool.
- GPT-4 few-shot: PC distance 0.155→0.127, Hausdorff 0.494→0.419, compile 96.0%→96.5%. Geometric-solver upper bound 0.103.
- Cost: ~$1000 total spend reported, broken down as $450 + $5 + $150 (which does not sum — the paper's own figures are inconsistent). Two refinement rounds, no gain past the second. No tokens.

**6. IterCAD** — https://arxiv.org/html/2606.13368v3 · https://github.com/KnowledgeXLab/IterCAD · CC BY-NC-SA 4.0 (paper)
Shanghai AI Lab + others, Aug 2026. IterCAD-Draw 1,000 cases, IterCAD-Edit 200, plus Text2CAD Bench and CADPrompt. Agentic loop vs direct inference: invalid rate 6.50%→0.30%, mean Chamfer 9.75→5.09, averaging 2.97 turns (max 5). Ablates *visual* feedback but never compiler/execution feedback alone. Reports turns, not tokens. **Best contamination handling of anything found**: test instances excluded from training, scripted cross-split geometric dedup, min normalised Chamfer between any train/test pair = 1.10.

**7. P3D-Bench** — https://arxiv.org/html/2606.11152v1 · https://lucasqaq.github.io/p3d/
**The only serious benchmark that covers OpenSCAD.** 400 text + 400 image + 203 assembly cases, from Text2CAD v1.1 and Fusion 360 Gallery. Programs in JSON / OpenSCAD / CadQuery / Three.js, all executed and rendered.
- Oracle is the richest of any found: geometry (Chamfer, F@0.05/0.01, normal consistency, CSG & voxel IoU), topology (open edges, inverted normals, non-manifold edges), VLM judge QA, and part-level Hungarian matching.
- Main eval is single-shot. A *supplementary* multi-turn run (≤10 turns, renders fed back) on Image-to-3D **with OpenSCAD**: Gemini 0.715→0.745; GPT-5.5 0.720→0.722, because it stopped after ~1.5 turns on average.
- **Cost: USD per task, plotted against score (Appendix D) — but for single-shot model comparison, not for the tool ablation.** No token counts. No contamination discussion, no stated data/code license.

**8. LLMForge / "Foundation Models for Automatic CAD Generation"** — https://arxiv.org/abs/2607.05573 · CC BY 4.0
Springer book chapter, Jul 2026. 97 problems over four geometry families. Interesting because it contrasts **IterTracer** (deterministic ray-traced analytic critique: silhouette IoU, hole visibility, edge clearance — no neural model) against **IterVision** (VLM judge). But there is **no no-feedback baseline**, and the two regimes are reported on different models/scopes so they are not directly comparable. No cost, no code URL, no contamination.

**9. TraceCAD** — https://arxiv.org/abs/2608.03062 · CC BY 4.0
Repair layer for CAD agents, DeepCAD-derived, 200-model ablations + 1K comparison. Ablates persistent state and localized search, not tool presence. Cost mentioned only qualitatively ("reduces retries, token cost, and latency" — no numbers). No code URL found.

---

### Tier 2 — benchmarks with no tool ablation (useful as substrate)

- **BenchCAD** — https://arxiv.org/html/2605.10865v1 · https://benchcad.github.io/BenchCAD_webpage/ · **data CC-BY-4.0 on HF, code MIT**. 17,900 verified CadQuery parts, 106 part families; tasks = Vision2Code, Code Edit (748 pairs), Vision QA / Code QA (2,400 items). Oracle: occupancy-grid IoU vs ground truth; QA answers derived deterministically from generation parameters. Execution used only for scoring. No cost, no contamination section. **Cleanest licensing of the lot.**
- **Parametric CAD Bench** — https://cadbench.ai/ (gnucleus.ai). V3 released 2026-09-21: 100 FreeCAD tasks (30 text-create, 30 create-and-edit, 40 engineering-drawing). Deterministic sandboxed grading on six axes including an explicit **efficiency axis covering token usage and execution time**, and the leaderboard lists **USD cost per entry**. Compares *harnesses* (Claude Code, Codex, mini-swe-agent, Grok Build, Antigravity) — notes a "visible harness effect" — but no with/without-verification arm. License unstated; unclear whether V3 tasks are public.
- **CADWorld** — https://arxiv.org/abs/2609.16251 · CC BY 4.0 · cad-world.github.io. 200 long-horizon FreeCAD **GUI computer-use** tasks, 11 workflow categories. Oracle: task-specific executable checks over saved FreeCAD artifacts (geometry, parametric structure, constraints, manufacturing state, simulation). Best of 7 agents 17.5% vs 87.0% expert. No cost, no ablation.
- **MUSE** — https://www.alphaxiv.org/abs/2605.28579 · https://github.com/dong7313/muse. Multi-part B-Rep assemblies. Three-stage oracle: sandbox execution → automated geometric checks (watertight, manifold, self-intersection, overlap) → rubric VLM judge for functionality/manufacturability/assemblability, validated against human experts (r = 0.713 sub-criteria, r = 0.835 instance). No cost, no ablation, license unstated.
- **Text2CAD-Bench** — https://arxiv.org/abs/2605.18430. 600 human-curated cases, 4 difficulty levels, dual-style prompts, public leaderboard. **Explicitly excludes multi-turn execution-feedback refinement** — i.e. deliberately scopes out your question. No dataset URL located.
- **Vision2CAD / GERD** — https://arxiv.org/abs/2609.22688. VLM reasoning + deterministic kernel ops with ID-based geometry selection; +11.1% mIoU on GERD-EVL. Six ablations, but they isolate the referencing interface, not tool presence. No released code found.
- **EvoCAD** — https://arxiv.org/abs/2510.11631 (IEEE ICTAI 2025). Evolutionary OpenSCAD-ish generation on CADPrompt. Worth stealing one idea: **Euler-characteristic-based topological metrics** as a cheap, reference-free correctness signal. No code, no cost.
- **ModelRift OpenSCAD benchmark** — https://modelrift.com/blog/openscad-llm-benchmark (2026-05-21, vendor blog, all rights reserved). n=1 task (build the Pantheon), 6 agent/model runs, all with the OpenSCAD CLI on PATH for render-and-iterate. Judged by the authors' 1–5 eyeball score. No with/without comparison, no cost. **One genuinely useful finding**: one agent's final exported STL diverged from the PNG previews it had been iterating against — i.e. render-based self-verification silently lied.

---

### Verdict

**No existing public work answers your question, and I checked from four directions to be sure.** CADTestBench is the only benchmark with a real machine-checkable geometric oracle *and* a clean same-model tool-on/off ablation (ReAct → +CADTests → +CADTests+Log, +4.5 to +9.5 points) — and it reports no token, turn or dollar cost whatsoever. The projects that do report cost report it for the wrong contrast: Parametric CAD Bench and P3D-Bench price *models and harnesses*, not verification conditions; the FEA paper gives only wall-clock (~7× for +13.4 partial-credit points and exactly one extra strict pass across 400 revisions). MAC is the sole artifact pairing tokens and dollars with a verification condition, and it is confounded — its no-verification arm is a reproduction of a different architecture over 10 self-scored prompts.

**Worth reusing:** BenchCAD's corpus (17.9k parts, CC-BY-4.0 data / MIT code — the only unambiguous licensing) as case supply; CADTestBench's per-case executable B-rep assertion taxonomy as the oracle design, which is almost exactly a partspec-style contract and is the strongest reason not to rebuild one; P3D-Bench's topology metrics and its OpenSCAD coverage; IterCAD's train/test geometric dedup as the only credible contamination method in the field; EvoCAD's Euler-characteristic invariant as a cheap reference-free check. **Not worth reusing:** CADCodeVerify as a verification baseline — it is VLM self-questioning, not a checker, and its own geometric solver needs the ground-truth mesh, so it cannot serve as a tool; CADPrompt and anything DeepCAD-derived without dedup; and every VLM-judge-only oracle, which cannot settle a question about machine-checkable tools.

**Two gaps that favour doing this work.** Contamination is essentially unhandled across the field — DeepCAD has been public since 2021 and is the common ancestor of CADPrompt, CADTestBench, TraceCAD and Text2CAD, and only IterCAD measures overlap at all. And OpenSCAD is nearly unserved: P3D-Bench's supplementary multi-turn run and a vendor blog post are the whole public record, with build123d covered only by MAC. The specific experiment — one model, one case set, machine-checkable tool on versus off, geometry oracle and token count both reported — is genuinely unrun, and the cost half is the part nobody has published for any CAD verification tool.
