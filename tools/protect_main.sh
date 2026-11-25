#!/usr/bin/env bash
# Apply the branch / tag rulesets from .github/rulesets/. Run AFTER the first CI run on main,
# so the required check names exist. Safe to re-run (updates in place).
set -euo pipefail
cd "$(dirname "$0")/.."

SLUG="Logivex/trader-calc"
gh auth status >/dev/null 2>&1 || { echo "Not logged in. Run: gh auth login"; exit 1; }

echo "==> checking that the required checks have run on main"
seen="$(gh api "repos/$SLUG/commits/main/check-runs" --paginate -q '.check_runs[].name' | sort -u)"
required="$(python3 -I -c '
import json
r = json.load(open(".github/rulesets/main.json"))["rules"]
for rule in r:
    if rule["type"] == "required_status_checks":
        for c in rule["parameters"]["required_status_checks"]:
            print(c["context"])
')"
missing=0
while IFS= read -r name; do
  if ! grep -qxF "$name" <<<"$seen"; then
    echo "  ! check '$name' has not run on main yet"; missing=1
  fi
done <<<"$required"
if [ "$missing" = 1 ]; then
  echo "    (The PR-title check only runs on pull requests, so it is expected to be missing now.)"
  read -r -p "    Apply the rules anyway? [y/N] " ans
  [ "$ans" = "y" ] || { echo "Aborted."; exit 1; }
fi

apply() { # <ruleset name> <json file>
  local id
  id="$(gh api "repos/$SLUG/rulesets" -q ".[] | select(.name==\"$1\") | .id")"
  if [ -n "$id" ]; then
    gh api -X PUT  "repos/$SLUG/rulesets/$id" --input "$2" >/dev/null && echo "  updated: $1"
  else
    gh api -X POST "repos/$SLUG/rulesets"     --input "$2" >/dev/null && echo "  created: $1"
  fi
}

echo "==> rulesets"
apply "main protection" .github/rulesets/main.json
apply "release tags"    .github/rulesets/tags.json

echo
echo "Done. From now on, changes to main go through pull requests (see CONTRIBUTING.md)."
echo "Emergency: Settings -> Rules -> Rulesets -> set 'main protection' to Disabled, fix, re-enable."
