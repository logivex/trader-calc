#!/usr/bin/env bash
# One-time GitHub setup: create the repo, push, configure merge rules and security.
# Safe to re-run. Needs: git, gh (logged in as the owner).
#
#   ./tools/setup_github.sh
#
# Afterwards, wait for the first CI run to finish, then run ./tools/protect_main.sh
set -euo pipefail
cd "$(dirname "$0")/.."

OWNER="Logivex"
REPO="trader-calc"
SLUG="$OWNER/$REPO"
DESC="A cross-platform trader's calculator (Windows, macOS, Linux, Android) - by Logivex"

command -v gh  >/dev/null || { echo "gh CLI not found"; exit 1; }
command -v git >/dev/null || { echo "git not found"; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "Not logged in. Run: gh auth login"; exit 1; }

login="$(gh api user -q .login)"
if [ "${login,,}" != "${OWNER,,}" ]; then
  echo "gh is logged in as '$login', expected '$OWNER'."; exit 1
fi

warn() { echo "  ! $*" >&2; }
try()  { "$@" >/dev/null 2>&1 || warn "skipped (not available / already set): $*"; }

echo "==> git identity"
# Commits in a public repo are permanent: use GitHub's private noreply address, not your real email.
noreply="$(gh api user -q .id)+$OWNER@users.noreply.github.com"
email="$(git config user.email || true)"
if [ -z "$email" ]; then
  git config user.email "$noreply"
  [ -n "$(git config user.name || true)" ] || git config user.name "$OWNER"
  echo "  set repo-local identity: $(git config user.name) <$noreply>"
elif [ "$email" != "$noreply" ]; then
  warn "git email is '$email'. It will be public in every commit."
  warn "To use the private address instead:  git config user.email '$noreply'"
  read -r -p "  Continue with '$email'? [y/N] " ans
  [ "$ans" = "y" ] || { echo "Aborted."; exit 1; }
fi

echo "==> local repo"
[ -d .git ] || git init -q -b main
git branch -M main
if ! git rev-parse HEAD >/dev/null 2>&1; then
  git add -A
  git commit -q -m "chore: initial project skeleton"
fi

echo "==> GitHub repo $SLUG"
if gh repo view "$SLUG" >/dev/null 2>&1; then
  git remote get-url origin >/dev/null 2>&1 || git remote add origin "https://github.com/$SLUG.git"
  git push -u origin main
else
  gh repo create "$SLUG" --public --description "$DESC" --source=. --remote=origin --push
fi

echo "==> merge settings: squash only, auto-delete branches, auto-merge allowed"
gh repo edit "$SLUG" \
  --enable-squash-merge --enable-merge-commit=false --enable-rebase-merge=false \
  --delete-branch-on-merge --enable-auto-merge \
  --enable-wiki=false --enable-projects=false
gh api -X PATCH "repos/$SLUG" \
  -f squash_merge_commit_title=PR_TITLE -f squash_merge_commit_message=PR_BODY >/dev/null

echo "==> topics"
try gh repo edit "$SLUG" --add-topic flutter,dart,trading,calculator,cross-platform,desktop,android,rtl

echo "==> security"
try gh api -X PUT "repos/$SLUG/vulnerability-alerts"
try gh api -X PUT "repos/$SLUG/automated-security-fixes"
try gh api -X PUT "repos/$SLUG/private-vulnerability-reporting"
try gh api -X PATCH "repos/$SLUG" --input - <<'JSON'
{"security_and_analysis":{"secret_scanning":{"status":"enabled"},"secret_scanning_push_protection":{"status":"enabled"}}}
JSON

echo "==> Actions: read-only default token, workflows can't approve PRs"
gh api -X PUT "repos/$SLUG/actions/permissions/workflow" \
  -f default_workflow_permissions=read -F can_approve_pull_request_reviews=false >/dev/null

cat <<MSG

Done: https://github.com/$SLUG

Next:
  1. Watch the first CI run:   gh run watch
  2. When it is green:         ./tools/protect_main.sh
MSG
