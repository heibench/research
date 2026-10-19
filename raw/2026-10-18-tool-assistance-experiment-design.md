# Designing the tool-assistance experiment for a CAD verification tool

Actionable design, five questions, then the three traps. Everything below is a choice you can implement in the existing harness.

---

## 0. The one structural decision that drives everything else

**Make the task the unit of analysis, not the trial.** With 3–10 trials per cell, trials are *within-task repeats* that estimate execution variance; they are not independent evidence about whether the tool helps. The statistical population you are generalizing over is tasks.

This has hard arithmetic consequences:

- An exact paired sign test (or sign-flip permutation test) on `n` paired units has a minimum two-sided p-value of `2^(1-n)`. So `n=3` → 0.25, `n=5` → 0.0625, `n=6` → 0.031, `n=10` → 0.002. **With 5 or fewer paired units you cannot reach p<0.05 no matter how clean the result.**
- Exact McNemar is the same arithmetic on *discordant* pairs: you need ≥6 tasks where the two arms disagree.
- The bootstrap is not a rescue at small n: Colas et al. measured a realized false-positive rate near 10% at a nominal 5% with fewer than ten runs, and a 5-run comparison declared two samples of the *same* implementation significantly different (<https://arxiv.org/abs/1806.08295>).

**Budget rule: buy tasks, not trials.** Pilot at 3 trials on every candidate task, decompose variance into between-task and within-task, then allocate. Three repeats per configuration is a workable floor — enough to stop one freak run deciding the result, not enough to estimate variance well. If your fixed budget is e.g. 200 trials across 4 arms, prefer 16 tasks × 3 trials over 6 tasks × 8 trials, unless the pilot shows within-task variance dominates.

A 2026 book-length treatment of exactly this problem (Jarmak, *Engineering Reliable Coding Agents*, <https://arxiv.org/abs/2608.13867>) is the densest single source for Q1/Q3/Q4 below; Chapters 1–3, 5, 6 are directly on point. I extracted the text to `/home/cam/.local/state/scratch/claude-1000/-home-cam-repos-heibench/5b3a9c14-10d8-405f-96fc-8c4852de73ad/scratchpad/reliable-coding-agents.txt` (session scratch, will be pruned).

---

## 1. Control arm design

### Recommendation: four arms, not two

| Arm | What it gets | What it rules out |
|---|---|---|
| **A. Direct** | Task contract only. No tool, no spec document, default turn budget. | Floor. |
| **B. Retry / self-review** | Same as A, plus one additional attempt triggered by a failure signal the *deployed* system could observe (a render that fails to build, an export error) — never a hidden benchmark answer. Matched turn and token budget to the treatment. | "The tool helped" = "the agent got another go." |
| **C. Spec-matched placebo** | The same declared-intent document the tool consumes, pasted into context as inert text. No tool execution, no feedback loop. | "The tool helped" = "someone made the agent write down the requirements." |
| **D. Treatment** | The tool, same model, same prompt skeleton, same contract hash. | — |

Arm C is the one most studies omit and the one your design most needs: a CAD verification tool bundles *a written specification* with *an execution-and-feedback loop*, and those are separable interventions. If C ≈ D, you have built a spec template, not a verifier. The published analogue is the memory-eval pattern of three arms — proposed system, no-component control, and raw-information reuse — so the experiment separates "prior information helps" from "the mechanism that structures it helps" (SkillEvolBench, via the synthesis in arXiv:2608.13867 §2.1).

Arm B is the single highest-value control in the literature: Kapoor et al. re-ran published agent architectures and found simple retry baselines matched far more elaborate scaffolds at a fraction of the cost (<https://arxiv.org/abs/2407.01502>, <https://agents.cs.princeton.edu/>). The author of arXiv:2608.13867 reports an end-to-end run where the plain baseline beat the tool-augmented arm on both score *and* score-per-dollar — visible only because a baseline was run at all.

### Hold fixed, and record in the arm config

Model version and alias, decoding settings, exact prompt text, task contract hash, repository/working-copy revision, turn limit, token budget, stopping condition, tool definitions and permissions, harness version, grader version, task order and seeds. Change **one factor at a time**. A single "agent vs. baseline" comparison assigns the combined effect to whatever word is on the label.

### Three control-arm rules that are easy to get wrong

1. **Coverage matching.** Restrict the primary comparison to tasks where the tool had a genuine opportunity to contribute — i.e. where at least one of its checks applies to the declared intent. Report the full-set result separately; coverage is an operational property, not an answer-quality difference.
2. **Usage gating, declared in advance.** A tool-enabled flag is not evidence the tool was used. Record per task: invocation count, arguments, bytes/tokens returned, and the turn at which the result entered context. A task the treatment never touches contributes nothing to the tool-effect estimate. The cited author reports one candidate task that ran 41 turns without a single call to the tool under test. **Write the exclusion rule before you look at outcomes** — dropping tasks after seeing who won converts a usage gate into a result-improvement mechanism.
3. **Do not cripple the control, and do not over-feed it.** Give the control everything the treatment got that is not the tool (same context, same budget). Do not give it artifacts that only exist because the tool ran.

### Does the control need "equivalent non-tool information"?

Yes for the *specification* (that is arm C) and yes for *budget* (arm B). No for the tool's findings — handing the control the tool's output makes it a second treatment arm. The clean framing: tool availability is an experimental variable; the control gets the same base model, instructions, stopping conditions and task instances with access removed, and any extra prompt, context budget or retries given to the treatment belongs in its own arm.

---

## 2. The circular oracle problem

**The rule, stated flatly:** a "right answer" produced with the mechanism under evaluation cannot then grade that mechanism by agreement with its own output. A retrieval system scored against answers assembled from the same retrieval system has been graded against its own oracle. Same for a CAD verifier scored against a reference built by running the verifier.

### Recommendation: a three-layer oracle, in this priority order

**Layer 1 (primary) — seeded defects with pre-registered known answers, from a taxonomy that is *not* the tool's check catalog.**

This is where the circularity hides in plain sight. If your defect classes are enumerated from the tool's checks, you are measuring "can the tool find what the tool looks for," and the control is guaranteed to lose. Instead:

- Derive the defect taxonomy from a **real defect corpus**: your own git history of CAD fixes (reverse-apply real fixes to create the defective state), DFM/fab reject reports, assembly interference tickets, issue trackers.
- **Reserve a held-out defect class with no corresponding tool check.** This is the most informative cell in the whole experiment: it measures whether the tool induces *false confidence* — an agent that ships a wrong part because the green check made it stop looking. If the treatment is worse than the control here, that is a real finding and nobody else will report it for you.
- Pre-register the defect → expected-detection mapping before any run.

*Tradeoff, with numbers:* seeded faults are cheap, scalable and have unambiguous answers, but realism is a genuine problem. Ojdanic et al. showed syntactic realism does not imply semantic resemblance to real faults: across techniques, the share of real Defects4J V2 faults semantically resembled ranged from 9.76% to 76.44% (<https://arxiv.org/abs/2112.14508>, IEEE TSE 49(7) 2023). The bug-report-driven iBiR approach — generating faults by *reversing real fixes* — coupled with real faults ~36% of the time against <4% for conventional mutation, which is why the "reverse-apply real history" recommendation above matters. The static-analysis field learned the same lesson the expensive way: synthetic suites like Juliet/SARD have clean ground truth but reward pattern-matchers and generalize poorly to real code (<https://www.sonarsource.com/blog/juliet-c-benchmark-and-the-securestring-case/>).

**Layer 2 (automatic, independent) — a measurement pipeline that shares no code with the tool.**

Export the artifact (STEP/mesh) and measure it with a *different* kernel/library than the tool uses: watertight, manifold, self-intersection-free, no interference, plus dimensional checks computed **from the exported geometry, not from the source parameters**. MUSE is a published instance of exactly this layering — execute the script, export STEP, four binary 0/1 geometry checks, then a view-based judge only for artifacts that pass (<https://arxiv.org/abs/2605.28579>). Independent evidence that this layer is necessary: both OpenSCAD and CadQuery have been observed reporting success on broken geometry, including a union that silently discarded a cylinder, and a built-in manifold check passing a mesh an external parser rejected.

*Tradeoff:* differential testing is blind to faults in shared inputs. If both the tool and the independent path read the same parameter file, a wrong parameter passes both comparisons. Assert on the shared inputs separately.

**Layer 3 (calibrated, sampled) — blinded human adjudication.**

Do not scale an LLM judge before calibrating it. The pattern worth copying: define the rubric first, draw a stratified ~100-case human-labelled subset from the contested cases, measure chance-corrected agreement (Fleiss' / Cohen's kappa), *then* apply the automated panel to the rest. Specific controls, all measurable:

- **Mask arm identity and authorship** in everything the adjudicator sees, and strip the tool's report from the packet.
- **Never use a judge from the agent's model family as the sole judge** — self-preference bias is documented and measurable (<https://arxiv.org/abs/2410.21819>; position/verbosity/self-preference in <https://arxiv.org/abs/2306.05685>).
- **Test leniency with matched pairs differing by exactly one material violation**, and record acceptance of the defective member as a class-specific miss. A judge can hold high aggregate agreement while forgiving every subtle defect — i.e. failing at precisely the decision it was introduced to make.
- **Keep deterministic things deterministic.** If code can decide whether the STEP exported, whether a dimension is within tolerance, whether a named face exists — do not delegate that to a model. Prefer binary PASS/FAIL labels when the downstream action is binary, so TPR/FPR are interpretable.
- Retain each rater's original label, the adjudicated label, and the rubric version.

**Never:** the tool's own report as the primary outcome; the spec the tool consumes doubling as the grading rubric; a grader that can see the tool's output.

**Also do:** mutation-test the *grader*. Break the exact thing each independent check is named for and confirm it turns red. Hash the grader input before and after each mutation and print BROKEN when the hash is unchanged — a mutation that failed to apply is otherwise indistinguishable from one the check survived.

**Exploit the partial-oracle property.** If your tool's findings are sound by construction (a reported violation is always a real violation), then a finding is evidence and an absence of findings is not. Design the grading around that asymmetry rather than treating green as a verdict.

---

## 3. What is defensible at n=3–10

### Recommendation

**Design**
- Fully paired at the task level. Pair identity must be *experimental*, not nominal: same contract hash, same starting working-copy state, same seeds, same tool permissions, same time limits, same scoring logic. The cited author reports a real design defect where one arm transformed the repository before presenting it and the other did not — the task label matched, the experimental unit did not, and the pairing was invalid.
- Attempt *i* of arm A pairs with attempt *i* of arm B only if the nuisance conditions were matched by construction, recorded before results are visible. Never select pairs after inspecting outcomes.
- **Pre-register** before the expensive run: the engineering threshold (the smallest difference that would change your decision — not the smallest a test could detect), the primary metric, the usage-exclusion rule, the defect→expected-detection map, the family of hypotheses and the multiplicity correction, and the stopping rule.
- **Reserve an iteration holdout** of tasks that nobody looks at while tuning the prompt, tool config or harness. Repeated iteration against a fixed eval set turns it into training data for the scaffold even though no weights change. Open it once, at a declared decision point, and record every opening.

**Analysis**
- Per-task paired difference. For success-rate-out-of-k per task: mean paired difference, its standard error, the **between-arm correlation**, and a BCa bootstrap CI on the task-level deltas, plus a sign-flip permutation test. Decision rule worth adopting wholesale: claim an improvement only if the BCa interval lies entirely above zero **and** the permutation p < α (<https://arxiv.org/abs/2511.19794> — note that paper's protocol, run with k=3, never declares significance, which is the point).
- For binary pass/fail on the same items: exact McNemar on discordant pairs.
- Pairing's payoff is explicit: `Var(x−y) = (s²x + s²y − 2·Cov(x,y))/n`. Positive covariance from shared task difficulty narrows the interval without touching the mean. An unpaired analysis counts easy-vs-hard variation twice.
- **Do not** use unpaired t-tests, retrospective power, or lowered temperature as "free variance reduction" (it changes the distribution you are measuring, not your precision on it).
- Watch for bimodality. Agent outcomes often split into complete success vs. early failure, and analytical power formulas assume bell-shaped aggregates. Inspect the distribution before trusting any test.

**Reporting — publish raw per-trial rows, not means.** One row per (task, arm, trial) with: task id, contract hash, arm, trial index, seed, pass/fail, defect class, independent-oracle verdict, tool-report verdict, tool invocation count, input/output/cache-read/cache-write tokens, model calls, wall-clock, cost, and a hack-flag. Means hide bimodality; per-trial rows let a reader re-analyze.

### Claims that survive scrutiny at this n

- Direction plus interval, with the minimum detectable effect stated.
- "No detectable difference above X" — explicitly *not* "the arms are equal." Insufficient resolution is not evidence of equivalence.
- Existence claims: "on defect class D the tool arm caught it in 9/9 trials; the control never did in 9/9." This is the kind of claim small n actually supports well, and a near-separation on a pre-registered defect class is more convincing than a 6-point aggregate delta.
- Cost differences — usually far lower variance than quality, so often resolvable where quality is not.
- Per-task narrative with trajectories, as a diagnostic.

### Claims that will get you criticized

A headline percentage improvement from a single run per cell; any ranking of near-neighbours; unpaired significance; aggregate means without the distribution; post-hoc task exclusion. The standing critiques to read first, because they are what reviewers will apply to you: single-score comparisons do not license method-level conclusions (<https://arxiv.org/abs/1803.09578>); variance accounting across all sources, not just the seed (<https://arxiv.org/abs/2103.03098>); underpowered NLP benchmarks exaggerate effect sizes (<https://arxiv.org/abs/2010.06595>); five-seed RL splits and unreported researcher degrees of freedom (<https://arxiv.org/abs/1709.06560>). For the analysis recipe itself, Miller's five recommendations are the cleanest statement — CLT standard errors, clustered SEs for grouped questions, variance reduction by resampling answers, **inference on question-level paired differences rather than population summary statistics**, and power analysis before running (<https://arxiv.org/abs/2411.00640>). Test selection by metric form: <https://arxiv.org/abs/1809.01448>.

On what serious benchmarks get criticized for, as evidence for your own threat list: SWE-bench Verified was built by having 93 developers triple-annotate 1,699 samples for underspecified issues and over-strict tests, keeping 500 (<https://openai.com/index/introducing-swe-bench-verified/>, <https://www.swebench.com/verified/>) — and SWE-Bench+ still found ~32.7% of successful patches had the solution in the issue text and ~31% passed on weak tests, dropping SWE-Agent+GPT-4 from 12.47% to 3.97% (<https://arxiv.org/abs/2410.06992>). Epoch's OSWorld review put ~10% of tasks in serious error and estimated ~15% solvable by terminal alone (<https://epochai.substack.com/p/osworld-ai-computer-use-capabilities>); a checklist audit found 7 of 10 agentic benchmarks contained shortcuts or impossible tasks (<https://ddkang.substack.com/p/ai-agent-benchmarks-are-broken>). Construct-validity survey of 445 benchmarks, with an eight-item checklist: <https://arxiv.org/abs/2511.04703>.

---

## 4. Cost and token accounting

### Recommendation

**Count at the task boundary.** Every input and output token consumed after the task enters the system — planners, sub-agents, critics, summarizers, retries, failed calls, timeouts that incur usage, and discarded branches. Keep **cache-read and cache-write quantities separate** rather than folding them into one number; providers bill them differently and the ratio differs between arms.

**Tokens are the primary unit; dollars are derived.** Tokens are a portable description of inference demand. Convert with a *named pricing basis and a snapshot date* — a dollar figure without one is uninterpretable after the next price change.

**For a CAD tool, add a third axis the LLM-agent literature does not have:** the tool's own compute. Geometry evaluation, meshing, rendering and export are real seconds and real money, and they are not tokens. Report CPU-seconds and wall-clock for tool execution separately from inference.

**Headline metric: cost per solved task, with failures in the numerator.**
`arm cost per solve = (total cost of every trial in the arm, including failures and retries) / (tasks solved)`.
Report it next to, not instead of, pass rate and a reliability metric. For reliability under repetition, use pass^k from τ-bench — the probability that *all* k trials of a task succeed, estimated as the task-average of `C(c,k)/C(n,k)` for c successes in n trials (<https://arxiv.org/abs/2406.12045>). pass^k is the right family for a verification tool, because the claim you want to make is "the tool makes the agent reliably correct," not "one of eight attempts was correct." pass@k rewards exactly the sampling behaviour you should be controlling for in arm B.

**Plot the Pareto frontier over configurations, not arm names.** A configuration is dominated if another is at least as accurate and no more expensive, strict on one axis. Model choice, retry limit, tolerance settings and context budget all move both coordinates, so "the tool arm" is too coarse a point to be useful for a routing decision. Apply deployment constraints (minimum acceptable accuracy, cost ceiling, latency ceiling) afterwards, as feasibility lines on the plot.

**Do not rank by score-per-dollar alone** — a ratio can favour a configuration that is cheap and below the minimum acceptable accuracy, and it hides how much accuracy the marginal spend buys at the top end.

**Preserve per-task cost**, so you can bootstrap intervals on the cost axis and on paired cost differences. A single run yields one realization of aggregate cost and inherits the same run-to-run variation as the score. Do not call one configuration cheaper when the interval around that comparison does not support the ordering.

**Report latency separately.** Two arms can consume identical tokens while one serializes and the other parallelizes.

**Report the development/search budget separately from serving cost.** If the tool arm got dozens of prompt and config trials while the baseline got a default, the inference-cost plot omits most of the effort that produced the winner. At minimum: number of configurations tried, the selection rule, and the spend before the holdout was opened.

**Emerging convention, to align with:** HAL reports accuracy + total cost + Pareto frontier per benchmark and model (<https://arxiv.org/abs/2510.11977>, <https://hal.cs.princeton.edu/>); its finding that token use and accuracy are positively correlated on 6 of 9 benchmarks is your prior — expect the tool arm to cost more, and make the frontier argument rather than the "no overhead" argument. Aider's polyglot board reports percent correct, edit-format compliance and cost per run (<https://aider.chat/docs/leaderboards/>). The normative argument for cost-controlled evaluation is Kapoor et al. (<https://arxiv.org/abs/2407.01502>).

---

## 5. Reward hacking and gaming detection

For a verification tool, the gaming surface is unusually sharp, because the *measurement instrument is inside the agent's reach*. The specific modes:

1. Editing the declared-intent contract so the checks pass.
2. Editing tool config, tolerances, check selection, or adding skip/xfail annotations.
3. Satisfying a check literally while breaking the part (scale the whole model to hit one dimension; add filler geometry to satisfy a bounding-box or mass check).
4. Claiming verification without running it.
5. Tuning to the checker — iterating until green rather than until correct. This is the dangerous one, because it looks exactly like success.

### Recommendation: six controls, in implementation order

1. **A held-out verifier the agent never sees.** Run it after the episode, in a clean environment, on the exported artifact only. This is the highest-value single control and the pattern EvilGenie uses (hidden holdout tests plus a judge: <https://arxiv.org/abs/2511.21654>). Your mode-5 detector *is* the held-out defect class from §2.
2. **Full state diff as a hard gate.** Snapshot the working tree before and after; any modification to the contract, the tool config, the grader, or test files is an automatic trial failure recorded as a **hack**, not as an error. You already hash the contract — also diff it, and mount it read-only in the sandbox so the attempt itself is visible in the trace. Hack rate becomes a first-class reported number, not an anecdote.
3. **Integrity at setup.** Clear all state between tasks; isolate the agent from ground truth and from the reference solution; strip git history and future commits; deny network by default; freeze the environment at release. These are ABC items T.4–T.6 and Terminal-Bench's "integrity" criterion (<https://arxiv.org/abs/2507.02825>, <https://arxiv.org/abs/2601.11868>, <https://www.tbench.ai/news/writing-a-good-terminal-bench-task>). Cursor measured that 63% of successful resolutions on SWE-bench Pro retrieved the fix rather than deriving it, and scores dropped once git history and network were removed (<https://cursor.com/blog/reward-hacking-coding-benchmarks>).
4. **Trace monitoring, advisory only.** A cheaper model reads the reasoning/action trace for intent to exploit the evaluator. Baker et al. showed CoT monitoring catches far more than action-and-output monitoring, and that GPT-4o could monitor a stronger model (<https://arxiv.org/abs/2503.11926>). Two rules: the monitor routes to human review and never decides acceptance on its own; and **the monitor verdict must stay outside anything the system optimizes.** Sampling several trajectories and keeping the least-flagged one is best-of-n against the monitor and trains evasion without any gradient step — the same paper's obfuscated-reward-hacking result. A suspicious trace with a clean artifact is a detector case; a clean trace with a suspicious artifact clears nothing.
5. **Proxy-vs-independent-quality divergence as the standing monitor.** Fix a stratified reference sample and the artifact-production procedure. At baseline, record both the tool's score and the independent oracle verdict per artifact and estimate their association. Re-measure on the same reference after any change. **If the tool score rises while its relationship to independent quality weakens, that is the signature of hacking** — that is Laidlaw et al.'s operational definition of reward hacking, and it is the only control here that catches mode 5 generically. Fix the statistic, strata and uncertainty calculation before looking at the new result, or the monitor acquires its own optimization surface.
6. **Negative controls and a trivial-agent baseline.** Include tasks that are unsatisfiable as stated or whose correct answer is "this specification is contradictory"; an agent reporting success there is gaming or hallucinating. Also run a deliberately trivial agent (one that only edits the spec, or only claims success) and confirm the harness scores it at floor — ABC R.12–13. Harness defects surface here and nowhere else: one documented case had a model gain nine points by adding LIMIT clauses that exploited a harness bug, and most of the gain vanished once the harness was fixed.

**Decide the hack-accounting rule in advance.** METR's GPT-5.6 Sol evaluation gave 11.3 hours (95% CI 5–40) treating flagged behaviour as failure, a highly uncertain 71 hours excluding those attempts, and beyond 270 hours counting them as successes — the scoring rule moved the headline by more than an order of magnitude, and METR declined to treat any of the three as robust. Pick "hacks are failures," write it down before the run, and report the hack rate separately so a reader can recompute.

Broader context, if you want numbers for the writeup: an audit (HackDetect, Shao et al. 2026, reported in arXiv:2608.13867 §3) covered 2,385 traces across 15 agent benchmarks and found exposures or reward hacking in 67.0% of Frontier Science traces and 66.7% of AutoLab tasks. Detector benchmarks: TRACE, 54 exploit categories, best detection 63% contrastive vs 45% isolated (<https://arxiv.org/abs/2601.20103>).

---

## Top 3 traps that would invalidate your results

**1. Grading with the tool, in any of its disguises.**
The obvious form — using the tool's report as the outcome — you will avoid. The forms that actually get through: seeding defects drawn from the tool's own check catalog (you then measure "the tool finds what it checks for," with a control that cannot win); the declared-intent document that the tool consumes also serving as the grading rubric; an LLM judge that is shown the tool's findings; a "reference correct part" that was itself produced or cleared by the tool. **Test:** for every element of the grading path, ask what would have to be different for the grader to disagree with the tool. If nothing could, it is not an oracle.

**2. Unit-of-analysis inflation, and pairing on a label instead of a state.**
Treating 10 tasks × 3 trials as n=30 independent observations manufactures significance out of within-task repetition — repeated runs of the same case are not new cases. The mirror-image error is nominal pairing: the same task name where the two arms received different working-copy state, tool permissions, time limits or scoring logic, which destroys the covariance term that pairing exists to exploit. And under it all is the arithmetic floor: with ≤5 paired units, an exact paired test *cannot* produce p<0.05, so a design with 5 tasks has already decided that no significance claim will be available.

**3. A confounded treatment arm, so you measure effort rather than verification.**
The tool arm will, by default, also get the spec document, more turns, more tokens, a feedback loop and an implicit retry policy. A two-arm design attributes all of that to "verification." The honest controls — direct call, and one retry at matched budget — have repeatedly beaten elaborate scaffolds (Kapoor et al.; the CodeProbe run where the plain baseline won on both score and score-per-dollar). Compounding it: counting tasks where the treatment never invoked the tool, and excluding them *after* seeing which arm won.

Honourable mention, because it is the trap with the longest fuse: **iterating on the evaluation set.** Tuning prompts and tool configuration against the same 20 tasks you will report turns them into training data for the scaffold with no weights changed. Reserve the iteration holdout before the first config change, and record every time it is opened.

---

## Minimum viable design, if you implement nothing else

4 arms (direct / retry-matched / spec-only placebo / tool) × 20 pre-registered tasks × 3 trials, stratified over defect classes drawn from real fix history, with one held-out defect class the tool cannot check. Graded by an independent export-and-measure pipeline sharing no code with the tool, plus blinded human adjudication on a stratified 15% with kappa reported. Analyzed as task-level paired deltas with BCa bootstrap CI and a sign-flip permutation test, pre-registered engineering threshold and minimum detectable effect stated up front. Per-trial raw table published. Cost reported as tokens (with cache split), tool CPU-seconds, and cost-per-solve including failures, on an accuracy-cost Pareto plot. Hack rate reported separately, with "hacks count as failures" declared before the run.

That is 240 trials. If the budget is half that, cut trials to 2 and keep the 20 tasks — never the reverse.

