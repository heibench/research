# Task runner for a prose repository.
#
# There is no build and no application code here, so most of the standard
# recipe set would be a TODO stub pretending to be a gate. The recipes below
# are the ones that do something; the ones that do not exist say so when asked
# rather than exiting 0 in silence.

set dotenv-load := false

# Default: show available recipes
default:
    @just --list

# Nothing to install: the only tool is pre-commit, run through uvx.
setup:
    @echo "no dependencies to install -- hooks are fetched by pre-commit on first run"

# Run every hook over every file (the CI equivalent).
check:
    uvx pre-commit@4.2.0 run --all-files --show-diff-on-failure

# Apply the hooks that mutate, rather than only reporting.
fmt:
    uvx pre-commit@4.2.0 run --all-files

[doc("Name the absent check rather than passing silently: this repo has no executable tests.")]
test:
    @echo "SKIP tests: no executable tests in this repository -- it holds prose, a bibliography and decision records."
    @echo "     The gate that applies here is \`just check\`. This is a check that does not apply, named so it is not"
    @echo "     mistaken for one that ran."
