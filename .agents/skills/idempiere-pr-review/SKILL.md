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
- **Backward compatibility**: no removed or changed public signatures. Overloads used.
- **Transactions**: `trxName` propagated, no stray commits.
- **Security**: no SQL injection, no cross-client data exposure, no role bypass, no secrets in logs.
- **English**, GPLv2 header on new files, no new warnings, readable code.
- **Tests**: a unit test for logic changes where feasible, and existing tests unaffected.
- **Collateral impact**: search for callers of every changed method or class and judge whether their behavior changes.

## 3. Functional review (local)

Use a disposable branch so `master` stays clean:

```bash
git checkout master
git pull upstream master
git checkout -b review-IDEMPIERE-<ticket>
git pull --no-commit https://github.com/<pr-author>/idempiere.git <pr-branch>
# or: gh pr checkout <number> --repo idempiere/idempiere
```

Replace `<ticket>`, `<pr-author>`, `<pr-branch>` and `<number>` with the values of the pull request under review.

Then:

1. Apply the PR's migration scripts: `bash RUN_SyncDBDev.sh` (tell the developer, since it modifies their DB).
2. Build (`./mvnw verify`) and run the relevant tests (`idempiere-unit-tests`).
3. Test the ticket scenario in the running application, if possible on GardenWorld.
4. Test beyond the happy path and check related areas that might be affected. The system should behave exactly as before except for the intended change.
5. Afterwards: `git checkout master` and delete the review branch if you no longer need it.

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
