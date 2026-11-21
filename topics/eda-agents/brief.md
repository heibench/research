# Brief: AI agents designing circuit boards

Written 2026-11-21, before any research was captured. It records what we set
out to find and how, so the findings can be read against the plan.

## Why

Posts showing a board "made entirely with AI" are now common on Reddit,
Hacker News, EEVblog and blogs, and the replies follow a pattern. One side says
it works. The other says the board is bad in ways a reviewer sees at a glance:
traces that are needlessly long, ugly or full of 90° corners; decoupling
capacitors far from the pins they serve; differential pairs left unmatched;
split or misused power planes; via stitching done wrong; and no research into
part choice, where a few datasheets and their reference layouts would have
done most of the work. A third reply is about method: "you are asking a
non-deterministic tool to do something that is mostly copying from the
datasheet; hand it the datasheets."

Each side has some truth. We want the evidence behind each, graded, because
boardwright's first rule is that KiCad is the judge, and these criticisms are
largely about what KiCad's DRC and ERC do not judge. boardwright already
reviews part of that (decoupler-to-pin distance, pair skew, reference-plane
continuity, ground vias beside signal vias, pour coverage; `docs/guide.md`,
"Mid-speed signals") and records the rest of what it does badly in
`docs/devlog/gaps.md`. This research says which of the remaining gaps matter,
and which belong in code, in the skill, or nowhere.

## Sub-questions

1. **Failure taxonomy.** What do reviewers say is wrong with AI-made boards?
   One entry per failure mode, under a design stage: requirements and
   architecture, part selection, schematic, placement, routing, power
   delivery, signal integrity, EMC, manufacturing (DFM, assembly, BOM) and
   documentation.
2. **Grading.** For each failure mode: is it real, real only under stated
   conditions (an edge rate, a frequency, a current, a layer count), or
   folklore? Settled from an authoritative source, such as a vendor
   application note or layout guide, an IPC standard, a textbook or a
   measurement, never from forum consensus. 90° corners is the expected
   example of a criticism that is mostly folklore below the GHz range;
   decoupler placement the expected example of one that is not. Both are
   hypotheses until the sources say so.
3. **AI-specific or beginner-generic.** Which failure modes are just as common
   in first boards people make themselves (r/PrintedCircuitBoard reviews these
   daily), and which are new or more frequent with agents: made-up or
   out-of-stock parts, pinouts recalled wrongly, autorouter output accepted
   untouched, DRC never run or its report never read, rendered images
   presented as a finished design.
4. **Who can catch it.** Each failure mode in exactly one place:
   - KiCad's ERC or DRC already catches it, given the right rules
   - netspec catches it (connectivity against declared intent)
   - boardwright's `REVIEW` already catches it
   - a deterministic check boardwright could add, with what it would measure
   - judgment only, so it is guidance for the skill, never a pass/fail
5. **Success claims.** When a post says an agent-made board works, what
   evidence comes with it? Graded: render or screenshot only; DRC/ERC
   reported clean; fabricated; powered up; tested against its function;
   measured (scope, current, thermal, EMC).
6. **Method.** Is there evidence beyond anecdote that grounding the agent in
   datasheets, reference designs and application notes, or researching parts
   before the schematic, changes the result? Includes the code-first tools
   (atopile, tscircuit, SKiDL) against tools that drive KiCad directly.
7. **Prior art.** What existing agent skills, MCP servers, commercial products
   and papers encode, whether any of it is *checked* rather than stated, and
   whether any board they produced was fabricated and tested. Starting list:
   kicad-happy, IxTechCrypto/kicad-skills, roccoagain/kicad-agent-skills,
   jvanderberg/kicad-skills, florianuhlemann/claude-skills,
   haohao-0725/PCB_Layout_with_AGENT_in_KiCAD, Novin3dp, alexchunlin,
   Prithvi-0g, 1999AZZAR/pcb-skill; kicad-mcp-pro, mcp-server-kicad,
   kicad-mcp, Konnect; Flux, Circuit Mind (ACE, AVE), atopile, tscircuit,
   Copperhead and copperbench; arXiv 2611.08175, 2602.00510, 2606.17074,
   2606.19795, 2608.31006, 2510.17002.
8. **Implications.** From 1 to 7: candidate boardwright checks, each a
   proposed issue with what it measures and the source behind its threshold;
   and the skill's content, as a list of rules each traced to a graded
   finding.

## Sources

| source | reach | use |
| --- | --- | --- |
| Hacker News | Algolia search API | threads on AI-designed boards and their replies |
| EEVblog forum, KiCad forum (forum.kicad.info) | web | critique threads, especially the EDA boards |
| Hackaday articles and comments | web | coverage and replies |
| GitHub | `gh` | skill and MCP repos: their skill files, READMEs, issues, any fabricated boards |
| arXiv | web | papers in sub-question 7 and their benchmarks |
| vendor and standards material | web | grading (sub-question 2): TI, ADI, ST, Microchip and Espressif layout guides; IPC-2221 and IPC-2141 where cited publicly; known authors such as Bogatin and Ott |
| Reddit | Reddit's sanctioned access only, once set up (see Decisions) | the largest single source of the threads this brief is about |

Window: 2025-01-01 to the capture date. Earlier threads only where a later one
links to them.

## Capture rules

These follow this repository's AGENTS.md and add four of their own.

- **Captures go in `raw/`** as `2026-11-2x-eda-agents-<slug>.md`, one per
  workstream, frozen once written.
- **Paraphrase and link, do not copy.** A capture records the claim in our
  words, the URL and the access date. A quotation is kept short and only where
  the wording is the evidence. No bulk copies of forum or Reddit text.
- **No usernames.** A claim is attributed to "a reply on <thread>", not to a
  person. These are private individuals' posts.
- **Every failure-mode instance records its evidence:** what board, what the
  reviewer saw, and whether anyone confirmed it (the poster agreeing, a
  measurement, a respin).
- **Saturation, not a quota.** A harvest stops when ten consecutive new
  threads add no failure mode to the list. Report how many threads were read.

## Outputs

Once the captures exist, the maintained layer in this directory:

- `findings.md`: the failure-mode table (mode, stage, grade and its source,
  AI-specific or not, who can catch it, boardwright status), the
  success-claim tally, and the method and prior-art findings.
- `bibliography.md`: one entry per source, stating what it established.
- Proposed boardwright issues and skill rules, listed in `findings.md` for
  review. Nothing is filed on boardwright until that review.

## Workstreams

Run as parallel research agents, each writing one capture.

| id | workstream | sub-questions | depends on |
| --- | --- | --- | --- |
| A | critique harvest: HN, EEVblog, KiCad forum, Hackaday | 1, 3 | none |
| B | success-claim audit: showcase posts and write-ups, graded by evidence | 5 | none |
| C | skills and MCP servers: read each repo's skill files and issues | 7 | none |
| D | commercial tools and papers | 6, 7 | none |
| E | grading: an authoritative source for each failure mode | 2 | A's list, seeded with the criticisms in "Why" |
| F | boardwright mapping: each failure mode against `REVIEW`, `gaps.md` and open issues | 4, 8 | A, E |
| R | Reddit harvest: A and B's questions, on Reddit | 1, 3, 5 | Reddit access (see Decisions) |
| V | verification: re-derive a sample of the claims and citations in A to E | all | A to E |

F is done in the session that owns this topic, not by an agent, because it
needs boardwright's code and decisions in hand. V is an independent pass by an
agent that has not seen the others' reasoning.

## Out of scope

- Building a dataset or a benchmark. If one follows, its cases go where
  heibench/research#2 decides, not here.
- Running boardwright or any EDA tool.
- Posting, replying or contacting anyone.

## Decisions

1. **Reddit is in scope, through Reddit's sanctioned access only.** On
   2026-11-21 `https://www.reddit.com/robots.txt` answered `User-agent: *`
   with `Disallow: /`, and points research use to Reddit's Public Content
   Policy and r/reddit4researchers. Our web search refuses reddit.com and
   redditinc.com because Reddit blocks that crawler. So we do not fetch
   Reddit pages; workstream R runs once access through Reddit's API or its
   research programme is set up, and the other workstreams do not wait for
   it. Until R has run, findings say which conclusions lack Reddit.
2. **The taxonomy is public.** heibench/research refuses defect taxonomies
   that would become a benchmark's answer key (#2). This one is design
   guidance, and the skill built from it ships publicly, so publishing it
   costs nothing that shipping the skill does not. Any benchmark cases later
   built from it go where #2 decides.
3. **Window:** 2025-01-01 to the capture date.
