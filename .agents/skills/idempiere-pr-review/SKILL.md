---
name: idempiere-pr-review
description: Reviewing iDempiere core pull requests or local diffs against the project's contribution rules. Use when asked to review a PR, test someone else's change, self-review your own diff before opening a PR, or write review findings for Jira or GitHub.
---

# Pull request review

Reference: https://docs.idempiere.org/docs/basic-development/contributing-to-core/pull-request-review

Every review answers two questions:

1. Is the code well written, without collateral damage or security issues?
2. Does it do what it claims, and only that?

## 1. Understand the change

- Read the Jira ticket linked on the first line of the PR (`IDEMPIERE-####`) and the PR description.
- List the commits and changed files:
  ```bash
  gh pr view <number> --repo idempiere/idempiere
  gh pr diff <number> --repo idempiere/idempiere
  # or, for a local self-review:
  git diff master...HEAD --stat
  git diff master...HEAD
  ```
- Check that the scope matches the ticket. Flag unrelated changes and refactoring mixed with the fix.

## 2. Code review

Go through `references/review-checklist.md`. The points core maintainers care about most:

- **PostgreSQL and Oracle**: SQL and migrations work on both.
- **Migrations present** when the dictionary or schema changed: both DB folders, correct naming, generated (not hand-written). Review them with the checklist in `idempiere-database-changes`.
- **Data access order**: model → `Query` → `DB` → JDBC, with resources closed and bind parameters used.
- **Backward compatibility**: no removed or changed public or protected signatures (overloads used). A breaking change is acceptable only if the PR author explicitly declares it (the "Breaking change" box in the PR template) and documents it. Even then, report it as a finding for the human reviewer or maintainers to accept. Never approve it on your own.
- **Transactions**: `trxName` propagated, no stray commits.
- **Security**: no SQL injection, no cross-client data exposure, no role bypass, no secrets in logs.
- **English**, GPLv2 header on new files, no new warnings, readable code.
- **Tests**: a unit test for logic changes where feasible, and existing tests unaffected.
- **Collateral impact**: search for callers of every changed method or class and judge whether their behavior changes.

## 3. Local verification, in gates

Run the cheap checks first. Go to the next gate only if the previous one passed. Otherwise report the findings (section 4) and stop.

### Gate 1: code review
Sections 1 and 2 above. Stop if there are blocking findings.

### Gate 2: build and tests

Check out the PR on a disposable branch with the bundled script. It needs a clean working tree and an `upstream` remote. On Windows, run it from Git Bash.

```bash
bash .agents/skills/idempiere-pr-review/scripts/review-pr.sh <pr-number>
```

It creates `review-pr-<pr-number>` from `upstream/master` with the PR merged in, so you test the code as it would be after merging. It prints the PR's commits, changed files and added migration scripts. If the PR doesn't merge cleanly, it says so and leaves nothing behind.

Then:

1. If the PR adds migration scripts, apply them with `bash RUN_SyncDBDev.sh`. This modifies the developer's database, so tell them first. A disposable database is better for reviews.
2. Do a clean build with the tests: `./mvnw clean verify -DskipTests=false`. Always use `clean` when moving between PRs, because leftover `target/` output can hide compile errors. While iterating, you can limit it to the affected test classes (see `idempiere-unit-tests`).
3. Stop and report if the build or any test fails. Mention tests that also fail on `master`.

### Gate 3: application test
Only after gates 1 and 2 pass:

1. Test the ticket scenario in the running application, preferably on GardenWorld (see `idempiere-headless-build-run`).
2. Test beyond the happy path and check related areas that might be affected. The system should behave exactly as before except for the intended change.

### Cleanup

```bash
bash .agents/skills/idempiere-pr-review/scripts/review-pr.sh --cleanup <pr-number>
```

Cleanup refuses if the review branch has commits of its own besides the review merge (for example a fix you prepared for the author), and lists them. Keep them first, or confirm with the developer before running `--cleanup --force <pr-number>`.

Manual fallback without the script (replace `<pr-number>`):

```bash
git fetch upstream master
git checkout --no-track -b review-pr-<pr-number> upstream/master
git fetch upstream pull/<pr-number>/head
git merge --no-ff FETCH_HEAD
```

## 4. Report findings

Write a report the developer can post on the Jira ticket or the PR (posting is their decision):

- **What was reviewed**: files, commits.
- **What was tested**: scenarios, DB (PostgreSQL / Oracle), commands run.
- **What worked.**
- **What failed or worries you**, each with file:line, a concrete failure scenario, and a suggested fix when possible.
- **What was not tested.** Be completely honest. Review quality affects the project and the reviewer's credibility.

Rank findings by severity (correctness, security and compatibility first; style last). Don't nitpick formatting the project doesn't enforce.

## Self-review before opening your own PR

Run sections 1 and 2 on `git diff master...HEAD`. Then confirm the PR description covers everything in `idempiere-contribution-workflow` §5 and the boxes of `pull_request_template.md` you can honestly check.
