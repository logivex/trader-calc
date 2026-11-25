# Contributing

## The one rule: `main` is always releasable

Nobody (including the maintainer) pushes to `main` directly. Every change goes through a pull request
that passes CI. This is enforced by a repository ruleset (see `.github/rulesets/`).

## Workflow

```bash
git switch main && git pull
git switch -c feat/short-description        # fix/..., docs/..., chore/..., refactor/...
# ... work, commit small and often ...
git push -u origin HEAD
gh pr create --fill                          # PR title MUST follow Conventional Commits
gh pr merge --auto --squash --delete-branch  # merges by itself once CI is green
```

## Conventional Commits (PR titles)

PRs are **squash-merged**, so the PR title becomes the commit on `main` and the line in the release notes.

```
<type>(optional scope): <summary in lower case, imperative>

feat(core): port numparse
fix(app): stop overflow in the calculators list on narrow windows
docs: explain the golden workflow
```

Types: `feat` `fix` `docs` `style` `refactor` `perf` `test` `build` `ci` `chore` `revert`.
Breaking change: add `!` (`feat(core)!: ...`).

## Core changes need golden tests

`packages/core` must reproduce `golden/*.json` exactly. Run `cd packages/core && dart test` before pushing.
The golden files are the frozen specification: do not touch them in a normal PR. If a calculator's behaviour must change on purpose, change the golden expectation in its own PR and say why.

## Releases

Maintainer only: bump `version` in `app/pubspec.yaml` via a PR, then tag the merge commit:

```bash
git switch main && git pull
git tag -a v0.2.0 -m "v0.2.0" && git push origin v0.2.0
```

Tags `v*` are protected: they cannot be moved or deleted.
