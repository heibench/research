# decisions/ — architecture decision records

One file per decision, numbered, never renumbered.

```
NNNN-short-kebab-title.md
```

## The format

```markdown
# NNNN — Title stated as the decision, not the topic

- **Status:** accepted | superseded by NNNN | revisited NNNN
- **Date:** YYYY-MM-DD

## Context
What was true that forced a choice. Facts and measurements, with the command
or source behind any number.

## Decision
What we are doing, in one or two sentences, in the present tense.

## Consequences
What this costs, what it forecloses, and what it leaves unresolved.

## Evidence
The bibliography entries and measurements this rests on. If a decision cites
nothing, say so -- a judgement call recorded as a judgement call is honest;
one dressed as a finding is not.

## What would change this
The named trigger. A decision with no reversal condition is a belief.
```

## Rules

- **Title the decision, not the subject.** "Keep eval harnesses in the tool
  repo" beats "Repository structure".
- **A superseded record is edited only in its Status line**, with a pointer
  forward. The reasoning stays wrong where it was written, because the point of
  the record is what was believed at the time and on what evidence.
- **Every record ends in a trigger.** The repo-structure research produced a
  "no" with four named conditions for revisiting; that list is the most useful
  part of the record, because it is what stops the question being re-litigated
  from scratch in six months.
- **Decisions, not standards.** A record says what *we* chose and why. When a
  decision hardens into a rule binding every repository, it belongs in
  dev-toolbox, and the record here should link to it. Keeping that boundary is
  why this repo does not become a second standards tracker.

Durable nos that are *declines* rather than choices may also be written as
dev-toolbox `.out-of-scope/` memos, which is the existing convention for
"considered properly and rejected on the merits". Use a memo when the output is
"we are not doing this"; use a record here when the output is "we are doing
this instead".
