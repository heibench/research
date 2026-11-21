# How to tell whether a verification tool helps

A method for answering "does giving an agent this tool produce better output,
and at what cost?" — written to be tool-agnostic, because the same question is
coming for every verification tool we maintain.

Sources for every claim are in [`bibliography.md`](bibliography.md). Where this
document departs from a source it says so in place.

---

## 1. State the question so it can fail

Write the question before the design, in a form where a specific result would
refute it. "Does the tool help?" is not that form; it has no failing outcome.

A usable form names the comparison, the outcome and the cost:

> Given a part that violates its contract, does the tool's **output** cause an
> agent to converge more often than the same agent working from the contract
> alone, and what does it cost in tokens?

Note what that narrowing does. It is **not** "tool versus nothing". A true
no-information arm would withhold the contract too, and for a contract-driven
tool that removes the task rather than the treatment. Claim what the design
measures: the tool's *output*, holding the written specification constant.

---

## 2. The unit of analysis is the task, not the trial

Trials are within-task repeats. They estimate execution variance; they are not
independent evidence that a tool helps. The population being generalised over is
tasks.

This has arithmetic consequences that cannot be argued with. An exact paired
sign test on `n` paired tasks has a minimum two-sided p-value of `2^(1-n)`:

| paired tasks | floor on p |
| ---: | ---: |
| 3 | 0.25 |
| 5 | 0.0625 |
| 6 | 0.031 |
| 10 | 0.002 |

**With five or fewer paired tasks, no significance claim is reachable, however
clean the result.** Exact McNemar is the same arithmetic over *discordant* pairs,
so it needs at least six tasks where the arms disagree. Bootstrapping does not
rescue this: at fewer than ten runs the realized false-positive rate was measured
near 10% against a nominal 5%, and a five-run comparison declared two samples of
the *same* implementation significantly different.

**Budget rule: buy tasks, not trials.** Pilot at three trials, decompose variance
into between-task and within-task, then allocate. If the budget halves, cut
trials to two and keep the tasks — never the reverse.

---

## 3. Arms

Two arms attribute everything to the label on the treatment. The tool arm also
receives, by default, a specification, a feedback loop, more turns and an
implicit retry policy. Four arms separate those:

| arm | what it gets | what it rules out |
| --- | --- | --- |
| **A — direct** | task only | floor |
| **B — retry, budget-matched** | A plus another attempt on a failure signal the deployed system could actually observe | "the tool helped" = "the agent got another go" |
| **C — specification placebo** | the declared intent the tool consumes, as inert text; no execution, no feedback | "the tool helped" = "someone made it write the requirements down" |
| **D — treatment** | the tool | — |

**Arm C is the one most studies omit and the one that matters most here**, because
a verification tool bundles *a written specification* with *an execution and
feedback loop*, and those are separable interventions. If C ≈ D, the product is a
spec template, not a verifier.

**Arm B is the highest-value control in the literature.** Re-running published
agent architectures found simple retry baselines matching far more elaborate
scaffolds at a fraction of the cost, and at least one reported run had the plain
baseline beat the tool-augmented arm on both score *and* score-per-dollar.

Hold fixed and record in the arm config: model version and alias, decoding
settings, exact prompt text, contract hash, working-copy revision, turn limit,
token budget, stopping condition, tool permissions, harness version, grader
version, task order and seeds. **Change one factor at a time.**

Three rules that are easy to get wrong:

- **Coverage matching.** Restrict the primary comparison to tasks where at least
  one of the tool's checks applies. Report the full set separately — coverage is
  an operational property, not an output-quality difference.
- **Usage gating, declared in advance.** A tool-enabled flag is not evidence the
  tool was used; record invocation count, arguments and the turn its result
  entered context. One reported candidate task ran 41 turns without a single call
  to the tool under test. **Write the exclusion rule before looking at outcomes**
  — dropping tasks after seeing who won converts a usage gate into a
  result-improvement mechanism.
- **Do not cripple the control, and do not over-feed it.** It gets everything the
  treatment got that is not the tool. It does not get artifacts that exist only
  because the tool ran.

---

## 4. The oracle must not be the tool

A mechanism cannot be graded by agreement with its own output. The obvious form
— using the tool's report as the outcome — is easy to avoid. These are the forms
that get through:

- seeding defects drawn from **the tool's own check catalog**, which measures
  "the tool finds what it checks for" against a control that cannot win;
- the declared-intent document the tool consumes **doubling as the grading
  rubric**;
- a judge that is **shown the tool's findings**;
- a "reference correct part" that was **produced or cleared by the tool**.

> **The test:** for every element of the grading path, ask what would have to be
> different for the grader to disagree with the tool. If nothing could, it is not
> an oracle.

### Three layers, in priority order

**Layer 1 — seeded defects with pre-registered known answers, from a taxonomy
that is not the tool's check list.** Derive the taxonomy from a real defect
corpus: reverse-apply real fixes from git history, fab reject reports, assembly
interference tickets. This matters empirically — syntactic realism does not imply
semantic resemblance, with the share of real faults resembled ranging from 9.76%
to 76.44% across techniques, while fault generation by reversing real fixes
coupled with real faults ~36% of the time against under 4% for conventional
mutation.

**Reserve a held-out defect class the tool has no check for.** This is the most
informative cell in the design: it measures whether the tool induces *false
confidence* — an agent that ships a wrong part because a green check made it stop
looking. If the treatment is worse than the control there, that is a real finding
and nobody else will report it for us.

**Layer 2 — an automatic measurement pipeline sharing no code with the tool.**
Export the artifact and measure it with a different kernel or library:
watertight, manifold, self-intersection-free, plus dimensional checks computed
**from the exported geometry, not from the source parameters**. Both OpenSCAD and
CadQuery have been observed reporting success on broken geometry, and in one
recorded case an exported STL diverged from the previews the agent had been
iterating against. *Limitation:* differential testing is blind to faults in
shared inputs — if both paths read the same parameter file, a wrong parameter
passes both. Assert on shared inputs separately.

**Layer 3 — blinded human adjudication on a sampled subset.** Calibrate before
scaling: rubric first, a stratified human-labelled subset, chance-corrected
agreement reported, *then* automate the rest. Mask arm identity and strip the
tool's report from the packet. Never use a judge from the agent's model family as
the sole judge. Test leniency with matched pairs differing by exactly one
material violation — a judge can hold high aggregate agreement while forgiving
every subtle defect, which is precisely the decision it was introduced to make.
Keep deterministic things deterministic: if code can decide it, code decides it.

**Mutation-test the grader.** Break the exact thing each independent check is
named for and confirm it turns red. Hash the input before and after each mutation
and print BROKEN when unchanged — a mutation that failed to apply is otherwise
indistinguishable from one the check survived.

**Exploit the partial-oracle property.** Where a tool's findings are sound by
construction — a reported violation is always real — a finding is evidence and an
*absence* of findings is not. Grade around that asymmetry instead of treating
green as a verdict.

---

## 5. Cost

**Count at the task boundary:** every input and output token after the task
enters the system — planners, sub-agents, critics, retries, failed calls,
discarded branches. Keep **cache-read and cache-write separate**; they are billed
differently and the ratio differs between arms.

**Tokens are primary, dollars derived** from a named pricing basis with a
snapshot date. A dollar figure without one is uninterpretable after the next
price change.

**Add the axis the LLM-agent literature lacks:** the tool's own compute. Geometry
evaluation, meshing and export are real seconds and real money and are not
tokens. Report tool CPU-seconds separately from inference.

**Headline metric: cost per solved task, with failures in the numerator** —
total cost of every trial in the arm, including failures and retries, divided by
tasks solved. Report it beside pass rate and a reliability metric, not instead of
them. For reliability under repetition use **pass^k** — the probability that all
k trials of a task succeed — because the claim worth making about a verification
tool is "reliably correct", not "correct in one of eight attempts". pass@k
rewards exactly the sampling behaviour arm B exists to control for.

**Plot a Pareto frontier over configurations, not arm names.** Model choice,
retry limit, tolerance settings and context budget all move both coordinates.
Apply deployment constraints afterwards as feasibility lines. **Do not rank by
score-per-dollar alone** — a ratio favours cheap configurations below the minimum
acceptable accuracy.

**Report the development budget separately from serving cost.** If the treatment
got dozens of prompt and config trials and the baseline got a default, the
inference-cost plot omits most of the effort that produced the winner.

**The prior to hold:** token use and accuracy were positively correlated on 6 of
9 benchmarks in the largest cost-aware survey. Expect the tool arm to cost more
and argue on the frontier. One artifact reports the opposite — a 116× token
reduction from geometric verification — but its arms are confounded. The
direction is genuinely open, which is why it is worth measuring.

---

## 6. Gaming

For a verification tool the measurement instrument is inside the agent's reach.
The modes, in rough order of subtlety: editing the contract so checks pass;
editing tool config, tolerances or check selection; satisfying a check literally
while breaking the part; claiming verification without running it; and **tuning
to the checker — iterating until green rather than until correct**, which is the
dangerous one because it looks exactly like success.

Six controls, in implementation order:

1. **A held-out verifier the agent never sees**, run after the episode on the
   exported artifact in a clean environment. Highest value for the effort.
2. **Full state diff as a hard gate.** Any modification to the contract, tool
   config, grader or tests is an automatic failure recorded as a **hack**, not an
   error. Hash *and* diff; mount read-only so the attempt is visible in the trace.
   Hack rate becomes a reported number, not an anecdote.
3. **Integrity at setup.** Clear state between tasks, isolate from ground truth
   and reference solutions, strip git history, deny network by default, freeze the
   environment at release. 63% of successful resolutions on one benchmark
   retrieved the fix rather than deriving it, and scores fell once history and
   network were removed.
4. **Trace monitoring, advisory only.** A cheaper model reads the trace for
   intent to exploit the evaluator. Two rules: it routes to human review and never
   decides acceptance, and **its verdict stays outside anything being optimised**
   — sampling trajectories and keeping the least-flagged one trains evasion with
   no gradient step.
5. **Proxy-versus-independent divergence as a standing monitor.** Fix a reference
   sample; record both the tool's score and the independent verdict; re-measure
   after any change. **If the tool score rises while its relationship to
   independent quality weakens, that is the signature of hacking** — the only
   control here that catches mode 5 generically. Fix the statistic and strata
   before looking at the new result.
6. **Negative controls and a trivial agent.** Include tasks that are unsatisfiable
   as stated; an agent reporting success there is gaming or hallucinating. Run an
   agent that only edits the spec and confirm the harness scores it at floor —
   harness defects surface here and nowhere else.

**Decide the hack-accounting rule in writing before the run.** One published
evaluation moved its headline from 11.3 hours to ~71 to beyond 270 purely by
changing whether flagged behaviour counted as failure, exclusion or success.
Default to "hacks are failures" and report hack rate separately so a reader can
recompute.

---

## 7. Contamination

Structural separation does **not** help: a second public repository has identical
exposure. Only privacy does, and only partially — a private test set defeats one
of five contamination types.

What is worth doing, in increasing strength: a canary string (one line, standard,
and demonstrably leaky — a frontier model reproduced the BIG-bench canary); not
publishing the answer key next to the case; and a **private held-out case set**,
shared with people on request but never crawlable. That last is the working model
used by serious evaluators, and the point is keeping material off the public web,
not keeping it secret from humans.

Note what this means for our own repositories: a public `FAILURE-MODES` document
that explains the finding an eval case is meant to elicit *is* the answer key, and
a tool whose `--help` points at its docs directory routes the agent to it.

---

## 8. Reporting

**Publish raw per-trial rows, not means.** One row per (task, arm, trial): task
id, contract hash, arm, trial index, seed, pass/fail, defect class, independent
oracle verdict, tool verdict, invocation count, tokens split by kind, wall-clock,
cost, and a hack flag. Means hide bimodality — agent outcomes often split into
complete success and early failure — and raw rows let a reader re-analyse.

**Strict and partial correctness get separate columns.** One study bought +13.4
mean requirement points for ~7× wall-clock while producing exactly one additional
strict pass across 400 revised submissions. A single blended score reproduces
that illusion perfectly.

Claims that survive scrutiny at this sample size: direction plus interval with
the minimum detectable effect stated; "no detectable difference above X", which
is **not** "the arms are equal"; existence claims on a pre-registered defect class
("caught in 9/9, control 0/9"), which small n supports well; and cost differences,
which usually have far lower variance than quality and so often resolve where
quality does not.

Claims that will not: a headline percentage from one run per cell, rankings of
near neighbours, unpaired significance, aggregate means without the distribution,
and post-hoc task exclusion.

**Pre-register before the expensive run:** the engineering threshold — the
smallest difference that would change a decision, not the smallest a test could
detect — the primary metric, the usage-exclusion rule, the defect-to-detection
map, and the stopping rule. **Reserve an iteration holdout** that nobody looks at
while tuning prompts or config; repeated iteration against a fixed set turns it
into training data for the scaffold with no weights changed.

---

## 9. The three traps

1. **Grading with the tool, in disguise.** Most often as a defect taxonomy
   enumerated from the tool's own checks.
2. **Unit-of-analysis inflation, and pairing on a label rather than a state.**
   Ten tasks × three trials is not n=30. And the mirror error — the same task name
   where the two arms received different working-copy state or budgets — destroys
   the covariance that pairing exists to exploit.
3. **A confounded treatment arm, measuring effort rather than verification.**
   The honest controls are a direct call and a budget-matched retry, and they have
   repeatedly beaten elaborate scaffolds.

Honourable mention, because it has the longest fuse: **iterating on the
evaluation set.**
