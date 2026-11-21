# Bibliography

Each entry says what the source **established**, not what it is about. An entry
that cannot state a finding does not belong here.

All URLs accessed **2026-10-18**. There is no link checker in the gate; where a
link rots, the arXiv ID, repository name or commit stands in for it.

Claims are attributed to their source, not endorsed. Where this repository
disagrees with a source, `methodology.md` says so in place.

---

## 1. CAD and CAD-as-code agent benchmarks

**CADTestBench** — <https://arxiv.org/abs/2605.07807> ·
<https://github.com/dimitrismallis/CADTestBench> · NeurIPS 2026 · public
The only benchmark found with both a machine-checkable geometric oracle and a
clean same-model tool-on/off ablation. 5,937 executable Python tests (~15 per
sample) query the B-rep through CadQuery for solid/shell validity, face and edge
counts, bounding boxes, wall thickness, volume, centre of mass and symmetry,
over 200 samples. Handing the agent the checker gained **+4.5 points on detailed
prompts and +9.5 on abstract** (Claude Sonnet: 0.580 → 0.625; 0.715 → 0.810).
**Reports no tokens, no turns and no dollars.** Tests are LLM-authored rather
than hand-written, with human agreement on 125 pairs at κ = 0.54 — moderate, and
a real weakness. Built on CADPrompt → DeepCAD; contamination not analysed.

**MAC (Multi-Agent CAD)** — <https://github.com/Pan-Chera/Multi-Agent-CAD> ·
MIT · build123d
The only public artifact placing tokens, dollars and verification condition in
one table: 103.95M tokens / $18.59 without in-loop verification against 0.90M /
$1.43 with geometric verification, at a higher feature pass rate (97.9% → 99.3%).
**The comparison is confounded** — the no-verification arm is a reproduction of a
different system, so architecture and verification condition move together — over
10 prompts and 141 features, self-scored with no external oracle. Treat the 116×
token reduction as the hypothesis worth testing, not as a result.

**Hephaestus (FEA as feedback)** — <https://arxiv.org/abs/2605.17448> · CC BY-SA 4.0
Ablates three tools independently over 408 cases. The FEA retry loop gained
**+13.4 mean requirement points** and cost roughly **7× wall-clock** (~10 min →
~68 min per item) — while producing **exactly one additional strict pass across
400 FEA-revised submissions**. Establishes that partial-credit metrics and strict
correctness can move in completely different proportions, which is the strongest
argument found for reporting them in separate columns. Also the only paper that
discusses its own leakage honestly.

**IterCAD** — <https://arxiv.org/html/2606.13368v3> ·
<https://github.com/KnowledgeXLab/IterCAD> · CC BY-NC-SA 4.0
Agentic loop against direct inference: invalid rate 6.50% → 0.30%, mean Chamfer
9.75 → 5.09, averaging 2.97 turns. **The only credible contamination handling
found in the field**: test instances excluded from training plus scripted
cross-split geometric deduplication, reporting a minimum normalised Chamfer of
1.10 between any train/test pair. Ablates visual feedback but never
compiler/execution feedback alone.

**P3D-Bench** — <https://arxiv.org/html/2606.11152v1>
The only serious benchmark covering **OpenSCAD** (alongside CadQuery, JSON and
Three.js), 400 text + 400 image + 203 assembly cases. Richest oracle found:
Chamfer, F-score, normal consistency, CSG and voxel IoU, plus topology checks
(open edges, inverted normals, non-manifold edges) and part-level Hungarian
matching. Reports **USD per task plotted against score**, but for single-shot
model comparison rather than any tool ablation.

**BenchCAD** — <https://arxiv.org/html/2605.10865v1> · data CC-BY-4.0, code MIT
17,900 verified CadQuery parts over 106 part families, with 748 code-edit pairs
and 2,400 QA items; oracle is occupancy-grid IoU against ground truth. **The only
unambiguous licensing found**, which makes it the realistic external case supply
if one is ever wanted. No cost reporting, no contamination section.

**Parametric CAD Bench** — <https://cadbench.ai/> · V3 released 2026-09-21
100 FreeCAD tasks graded deterministically on six axes including an explicit
**efficiency axis covering token usage and execution time**, with USD cost per
leaderboard entry. Establishes that cost-aware CAD leaderboards are already
conventional — but it compares *harnesses* (Claude Code, Codex, mini-swe-agent
and others, noting a visible harness effect), never a with/without-verification
arm. License unstated.

**CADSmith** — <https://www.alphaxiv.org/abs/2603.26512> ·
<https://github.com/jabarkle/CADSmith>
100 prompts; oracle is exact OpenCASCADE measurement feeding a correction loop
plus a VLM judge on three-view renders. Zero-shot → full loop: execution 95% →
100%, median IoU ~0.81 → 0.96, mean Chamfer 28.37 → 0.74. Ablates removing the
*renders* but never the kernel-metric check alone, so it cannot separate the two.

**CADCodeVerify / CADPrompt** — <https://arxiv.org/abs/2410.05340> ·
<https://github.com/Kamel773/CAD_Code_Generation> · ICLR 2025
The ancestor of this line and the source of CADPrompt (200 CadQuery objects from
DeepCAD). **Establishes a negative worth knowing: it is not a machine-checkable
tool.** It is VLM self-questioning, and the paper's own geometric-solver baseline
*requires the ground-truth mesh*, which the authors correctly label an upper
bound rather than a usable tool. Not a valid "verification tool" baseline.

**MUSE** — <https://www.alphaxiv.org/abs/2605.28579> ·
<https://github.com/dong7313/muse>
Multi-part B-Rep assemblies with a three-stage oracle: sandbox execution →
automated geometric checks (watertight, manifold, self-intersection, overlap) →
rubric VLM judge, validated against human experts at r = 0.713 and r = 0.835.
A published instance of layering a cheap deterministic oracle under an expensive
judge rather than replacing one with the other.

**CADWorld** — <https://arxiv.org/abs/2609.16251> · CC BY 4.0
200 long-horizon FreeCAD **GUI computer-use** tasks with executable checks over
saved artifacts. Best of seven agents scored 17.5% against 87.0% for experts,
establishing how far GUI-driven CAD agency is from competence.

**EvoCAD** — <https://arxiv.org/abs/2510.11631> · IEEE ICTAI 2025
Contributes one reusable idea: **Euler-characteristic topological invariants** as
a cheap, reference-free correctness signal.

**ModelRift OpenSCAD benchmark** — <https://modelrift.com/blog/openscad-llm-benchmark>
· vendor blog, n=1, author-scored
Methodologically weak, but records one failure mode precisely: an agent's final
exported STL **diverged from the PNG previews it had been iterating against**.
Render-based self-verification silently lied. The cleanest published argument for
machine-checkable contracts over visual self-review.

Also surveyed without a tool ablation: **LLMForge**
(<https://arxiv.org/abs/2607.05573>), **TraceCAD**
(<https://arxiv.org/abs/2608.03062>), **Text2CAD-Bench**
(<https://arxiv.org/abs/2605.18430>, which explicitly scopes *out* multi-turn
execution feedback), **Vision2CAD/GERD** (<https://arxiv.org/abs/2609.22688>).

---

## 2. Experiment design and small-sample statistics

**Jarmak, *Engineering Reliable Coding Agents*** — <https://arxiv.org/abs/2608.13867>
Book-length 2026 treatment of control arms, pairing, cost accounting and usage
gating for agent experiments. Source for the usage-gating rule (one task ran 41
turns without invoking the tool under test) and for a reported end-to-end run in
which the plain baseline beat the tool-augmented arm on both score and
score-per-dollar — visible only because a baseline was run.

**Kapoor et al., *AI Agents That Matter*** — <https://arxiv.org/abs/2407.01502> ·
<https://agents.cs.princeton.edu/>
Re-ran published agent architectures and found **simple retry baselines matched
far more elaborate scaffolds at a fraction of the cost**. The normative argument
for cost-controlled evaluation, and the reason a retry-matched arm is the single
highest-value control.

**Colas et al.** — <https://arxiv.org/abs/1806.08295>
Measured a realized false-positive rate near **10% at a nominal 5%** with fewer
than ten runs, and a five-run comparison declaring two samples of the *same*
implementation significantly different. Establishes that bootstrapping does not
rescue small n.

**Miller, *Adding Error Bars to Evals*** — <https://arxiv.org/abs/2411.00640>
Five recommendations, of which the load-bearing one here is **inference on
question-level paired differences rather than population summary statistics**.

**Ojdanic et al.** — <https://arxiv.org/abs/2112.14508> · IEEE TSE 49(7) 2023
Syntactic realism of seeded faults does not imply semantic resemblance to real
ones: across techniques, the share of real Defects4J V2 faults semantically
resembled ranged from **9.76% to 76.44%**. Fault generation by *reversing real
fixes* (iBiR) coupled with real faults ~**36%** of the time against **<4%** for
conventional mutation. The evidence behind deriving defect cases from real fix
history rather than from a tool's check catalog.

Supporting critiques of single-run and underpowered comparison:
<https://arxiv.org/abs/1803.09578> (single scores do not license method-level
conclusions), <https://arxiv.org/abs/2103.03098> (variance accounting beyond the
seed), <https://arxiv.org/abs/2010.06595> (underpowered NLP benchmarks exaggerate
effect sizes), <https://arxiv.org/abs/1709.06560> (five-seed RL splits and
researcher degrees of freedom), <https://arxiv.org/abs/1809.01448> (test
selection by metric form), <https://arxiv.org/abs/2511.19794> (a BCa-interval
plus sign-flip-permutation protocol which, run at k=3, never declares
significance — the honest outcome of small n).

**LLM-judge bias** — <https://arxiv.org/abs/2306.05685> (position, verbosity and
self-preference effects), <https://arxiv.org/abs/2410.21819> (self-preference
measured). Establishes that a judge from the agent's own model family cannot be
the sole adjudicator.

---

## 3. Benchmark validity, and how benchmarks fail

**SWE-bench Verified** —
<https://openai.com/index/introducing-swe-bench-verified/> ·
<https://www.swebench.com/verified/>
93 developers triple-annotated 1,699 samples for underspecification and
over-strict tests, keeping **500**. The cost of making an existing benchmark
trustworthy, stated in person-effort.

**SWE-Bench+** — <https://arxiv.org/abs/2410.06992>
Of successful patches, **~32.7% had the solution present in the issue text** and
**~31% passed on weak tests**; correcting for this dropped SWE-Agent+GPT-4 from
**12.47% to 3.97%**. The clearest demonstration that a headline agent score can
be mostly artifact.

**Epoch, OSWorld review** —
<https://epochai.substack.com/p/osworld-ai-computer-use-capabilities>
~10% of tasks in serious error, ~15% solvable by terminal alone.

**Agentic benchmark checklist (ABC)** — <https://arxiv.org/abs/2507.02825> ·
<https://arxiv.org/abs/2601.11868>; and
<https://ddkang.substack.com/p/ai-agent-benchmarks-are-broken>, which found
**7 of 10** agentic benchmarks contained shortcuts or impossible tasks. Source of
the trivial-agent and negative-control recommendations.

**Construct validity survey** — <https://arxiv.org/abs/2511.04703>
445 benchmarks assessed against an eight-item checklist.

---

## 4. Cost accounting

**HAL (Holistic Agent Leaderboard)** — <https://arxiv.org/abs/2510.11977> ·
<https://hal.cs.princeton.edu/>
Reports accuracy, total cost and a Pareto frontier per benchmark and model, and
finds **token use and accuracy positively correlated on 6 of 9 benchmarks**. The
prior to hold: expect a verification arm to cost *more*, and argue on the
frontier rather than claiming no overhead. Directly contradicts MAC's 116×
reduction, which is why the cost direction is an open empirical question.

**τ-bench, pass^k** — <https://arxiv.org/abs/2406.12045>
The probability that *all* k trials of a task succeed, estimated as the
task-average of C(c,k)/C(n,k). The right reliability family for a verification
tool, where the claim is "reliably correct" rather than "correct in one of
eight attempts".

**Aider leaderboards** — <https://aider.chat/docs/leaderboards/>
Percent correct, edit-format compliance and cost per run reported together, as
an existing convention to align with.

---

## 5. Reward hacking and gaming detection

**Baker et al., CoT monitoring** — <https://arxiv.org/abs/2503.11926>
Chain-of-thought monitoring catches substantially more than action-and-output
monitoring, and a weaker model can monitor a stronger one. Also establishes the
constraint that matters operationally: **optimising against the monitor — such as
sampling several trajectories and keeping the least-flagged — trains evasion with
no gradient step.**

**Cursor, reward hacking on coding benchmarks** —
<https://cursor.com/blog/reward-hacking-coding-benchmarks>
**63% of successful resolutions on SWE-bench Pro retrieved the fix rather than
deriving it**, and scores dropped once git history and network access were
removed. The evidence for stripping history and denying network by default.

**EvilGenie** — <https://arxiv.org/abs/2511.21654>
Hidden holdout tests plus a judge as a detection pattern — the held-out verifier
the agent never sees.

**METR, GPT-5.6 Sol evaluation**
The hack-accounting rule moved the headline by more than an order of magnitude:
11.3 hours treating flagged behaviour as failure, ~71 hours excluding those
attempts, beyond 270 hours counting them as successes — with none treated as
robust. Establishes that the rule must be fixed in writing before the run.

**TRACE** — <https://arxiv.org/abs/2601.20103> — 54 exploit categories; best
detection 63% contrastive against 45% isolated. **HackDetect** (Shao et al. 2026,
reported in arXiv:2608.13867 §3) — 2,385 traces across 15 agent benchmarks, with
exposures or reward hacking in 67.0% of Frontier Science traces.

---

## 6. Contamination

**BIG-bench canary contamination** —
<https://www.lesswrong.com/posts/kSmHMoaLKGcGgyWzs/big-bench-canary-contamination-in-gpt-4>
GPT-4-base could reproduce the BIG-bench canary string. Establishes that canaries
are worth one line and are **demonstrably leaky**.

**METR, autonomy evaluation resources** —
<https://metr.org/blog/2024-03-13-autonomy-evaluation-resources>
31 fully public task implementations with ~100 more shared privately on request,
**specifically to keep them out of training corpora** — access granted liberally.
The model for a private held-out case set: the goal is keeping material off the
crawlable web, not keeping it secret from people.

**GAIA** — <https://huggingface.co/datasets/gaia-benchmark/GAIA> — gated dataset
with a public dev split and a private test split scored by a leaderboard.
**ARC-AGI** — <https://arcprize.org/guide> — public, semi-private and private
tiers with offline sandboxed scoring and results withheld until solutions are
open-sourced.

**Publishing a benchmark, and contamination taxonomy** —
<https://arxiv.org/html/2505.18102v1> (of 47 benchmarks cited by frontier labs,
33 fully open and only 13 held-out, private or live) ·
<https://arxiv.org/pdf/2608.29463> (a private test set defeats only one of five
contamination types).

---

## 7. Evaluation repository structure

**SWE-bench** — harness, task instances on Hugging Face, a task-source repo, a
cloud submission CLI, and **SWE-bench/experiments** for results, whose README
states the governing rule: *"This repository holds entries, not artifacts"* —
predictions and trajectories stay in each submitter's own repo, named in a
`metadata.yaml`, explicitly to keep the repo small enough to clone.

**inspect_ai / inspect_evals** —
<https://github.com/UKGovernmentBEIS/inspect_ai> ·
<https://github.com/UKGovernmentBEIS/inspect_evals>
Framework and 200+ evaluations split into two repos, driven by having many eval
authors who are not the framework's maintainers.

**Terminal-Bench → Harbor** — <https://github.com/laude-institute/terminal-bench>
· <https://github.com/laude-institute/harbor>
Split at the 2.0 release, when the harness became a product that also runs
SWE-Bench and Aider Polyglot, with datasets addressed `name@version`.

**In-repo harnesses** — EleutherAI `lm-evaluation-harness` (tasks as in-repo
YAML, datasets from HF at runtime, results never committed),
`bigcode-evaluation-harness`, Stanford CRFM `helm` (no results directory;
leaderboards published to a site), Aider (`benchmark/` in the tool repo, exercises
in a separate repo, results to a timestamped local directory).

Taken together these establish that **repository splits are driven by third-party
submissions, many external eval authors, or a product boundary — not by
directory size.**

**openai/evals** — <https://github.com/openai/evals> — the one surveyed project
using Git LFS for eval data, and the cautionary case: LFS meters bandwidth on
every clone and CI checkout. See GitHub's own guidance,
<https://wellarchitected.github.com/library/architecture/recommendations/scaling-git-repositories/when-to-use-git-lfs>.
