#!/bin/bash
# Check out an iDempiere core pull request for local review.
#
# Usage:
#   review-pr.sh <pr-number>                    create branch review-pr-<n>: upstream/master with the PR merged in
#   review-pr.sh --cleanup <pr-number>          switch back to master and delete review-pr-<n>
#   review-pr.sh --cleanup --force <pr-number>  delete it even if it has your own commits on top
#
# Requires a git remote named "upstream" pointing to idempiere/idempiere.
# On Windows, run it from Git Bash.

set -euo pipefail

usage() {
	sed -n '4,7p' "$0" | sed 's/^# \{0,1\}//'
	exit 1
}

CLEANUP=false
FORCE=false
if [ "${1:-}" = "--cleanup" ]; then
	CLEANUP=true
	shift
	if [ "${1:-}" = "--force" ]; then
		FORCE=true
		shift
	fi
fi
PR="${1:-}"
[[ "$PR" =~ ^[0-9]+$ ]] || usage
BRANCH="review-pr-$PR"

cd "$(git rev-parse --show-toplevel)"

if ! git diff --quiet || ! git diff --cached --quiet; then
	echo "Working tree has uncommitted changes. Commit or stash them first." >&2
	exit 1
fi

if $CLEANUP; then
	PR_REF="refs/remotes/upstream/pr/$PR"
	if ! git show-ref --verify --quiet "refs/heads/$BRANCH"; then
		echo "Branch $BRANCH does not exist. Nothing to clean up."
		git update-ref -d "$PR_REF" 2>/dev/null || true
		exit 0
	fi
	if ! $FORCE; then
		# Commits on the branch that are neither in master nor in the PR.
		# A branch created by this script has exactly one: the review merge commit.
		if ! git show-ref --verify --quiet "$PR_REF"; then
			echo "Cannot verify $BRANCH: $PR_REF is missing. Use --force to delete it anyway." >&2
			exit 1
		fi
		EXTRA=$(git rev-list --count "$BRANCH" --not upstream/master "$PR_REF")
		if [ "$EXTRA" -gt 1 ]; then
			echo "$BRANCH has commits of its own besides the review merge:" >&2
			git log --oneline "$BRANCH" --not upstream/master "$PR_REF" >&2
			echo "Keep them (e.g. push or cherry-pick) or run: $0 --cleanup --force $PR" >&2
			exit 1
		fi
	fi
	git checkout master
	git branch -D "$BRANCH"
	git update-ref -d "$PR_REF" 2>/dev/null || true
	echo "Deleted $BRANCH. If you applied the PR's migration scripts, your database still contains them."
	exit 0
fi

if ! git remote get-url upstream >/dev/null 2>&1; then
	echo "No 'upstream' remote. Add it with:" >&2
	echo "  git remote add upstream https://github.com/idempiere/idempiere.git" >&2
	exit 1
fi

if git show-ref --verify --quiet "refs/heads/$BRANCH"; then
	echo "Branch $BRANCH already exists. Run: $0 --cleanup $PR" >&2
	exit 1
fi

git fetch upstream master "pull/$PR/head:refs/remotes/upstream/pr/$PR"
git checkout --no-track -b "$BRANCH" upstream/master
if ! git merge --quiet --no-ff --no-edit -m "Review PR #$PR" "upstream/pr/$PR"; then
	echo "The PR does not merge cleanly onto upstream/master. Report the conflict to the PR author." >&2
	git merge --abort
	git checkout master
	git branch -D "$BRANCH"
	exit 1
fi

echo
echo "== Branch $BRANCH: upstream/master + PR #$PR"
echo
echo "== Commits in the PR"
git log --oneline "upstream/master..upstream/pr/$PR"
echo
echo "== Changed files"
git diff --stat upstream/master...HEAD
echo
echo "== Migration scripts added by the PR"
MIGRATIONS=$(git diff --name-only --diff-filter=A upstream/master...HEAD -- migration/)
echo "${MIGRATIONS:-(none)}"
