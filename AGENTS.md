# AGENTS.md — research

A prose repository for the org's research, split by topic under `topics/`. No
application code, no build, no tests.

## Commands

```
just check    # every pre-commit hook over every file -- the CI equivalent
just fmt      # the same hooks, allowed to mutate
just test     # names the absent check; there are no executable tests here
```

`just test` prints `SKIP tests:` and exits 0 on purpose. A check that does not
apply may pass, but it has to say so by name — an unmentioned check is
indistinguishable from one that never ran.

## What belongs here, and what does not

| this repo | elsewhere |
| --- | --- |
| a topic's question, method and synthesis under `topics/<topic>/` | a harness or cases → the tool's own repo |
| prior art with a stated finding per source | a rule binding every repository → `dev-toolbox` |
| decision records with a reversal trigger | open work → the issue tracker of the repo whose code changes |
| verbatim captured research in `raw/` | answer keys, defect taxonomies, held-out classes → **never public** |

The last row is not a style preference. Publishing a defect taxonomy next to the
cases it describes contaminates the benchmark; see
`topics/agent-evaluation/methodology.md` §7. Where such material is needed, it
waits on heibench/research#2.

## Topics

- **One directory per question**, `topics/<kebab-name>/`, with a `README.md`
  that states the question, lists the files, and carries a status line kept
  true. A topic that has none of its own sources needs no `bibliography.md`.
- **Topics do not share a bibliography.** A source used by two topics gets an
  entry in each, stating what it established *for that question*.
- **Decisions are not per topic.** All records go in `decisions/`, numbered in
  one sequence, and name the topic they came from.

## Writing rules

- **An entry in a topic's `bibliography.md` states what a source
  established**, not what it is about. If you cannot write the finding, the
  source does not go in.
- **Numbers carry the command or source that produced them.** An estimate is
  fine when labelled; a presented measurement must be one.
- **Claims are attributed, not endorsed.** Where this repo disagrees with a
  source, say so in place rather than silently omitting the source.
- **Prefer "here is a case" to "every" or "never"**, which fail on the first
  counter-example.
- **Citations carry an access date** plus an arXiv ID, repo name or commit SHA.
  There is no link checker, on purpose — see the README.

## `raw/` is frozen

Captures under `raw/` are never edited after capture: not for typos, not for
formatting, not for a moved link. The whitespace hooks skip the directory for
exactly that reason. Corrections go in the topic, which is the maintained
layer, and say what they are correcting. Superseded reports are kept, not
deleted. `raw/README.md` is the index, not a capture, and is updated with each
one.

New captures are named `YYYY-MM-DD-<topic>-<slug>.md`. The `2026-10-18-*` files
predate the convention and keep their names.

## Decision records

Numbered, never renumbered, one decision per file, each ending in the trigger
that would reverse it. Format and rules in `decisions/README.md`. A decision
with no reversal condition is a belief, not a decision.

## Gotchas

- **Hook revs here are deliberately ahead of `dev-toolbox/templates/`**, which
  ships `gitleaks v8.27.2` and `pre-commit-hooks v5.0.0` with no ecosystem
  watching them (`CameronBrooks11/dev-toolbox#72`). Do not "restore consistency"
  by copying the template values back.
- **`pre-commit install` cannot be run from an agent session** — `.git/hooks` is
  mounted read-only under a working directory. It is a hand step, and commits
  made before it runs have executed no hooks.
