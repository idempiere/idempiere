# AGENTS.md — iDempiere core

Guidance for AI coding agents (Claude Code, Gemini CLI, Qwen Code, Codex, OpenCode, …) working on the iDempiere core repository.
iDempiere is an open-source ERP/CRM/SCM (Java 17, OSGi/Equinox, Maven + Tycho, ZK web UI, PostgreSQL and Oracle).

The human-facing source of truth is the documentation site: https://docs.idempiere.org/docs/basic-development/contributing-to-core/contributing-to-idempiere
If this file and the documentation disagree, the documentation wins.

## Hard rules (always apply)

1. **Never commit to `master`.** Work on a branch named `IDEMPIERE-####-short-description`.
2. **Every commit references a Jira ticket**: `IDEMPIERE-#### Short description`. One ticket per pull request; a refactoring goes in its own commit, separate from the fix.
3. **Never write migration scripts or Application Dictionary IDs.** Do not hand-write `INSERT`/`UPDATE` on `AD_*` tables, do not invent `*_ID` or `*_UU` values, do not create files under `migration/`. The developer generates these from the iDempiere UI with Centralized IDs. Your job is to tell them what to create and to review what they generated. See `idempiere-database-changes`.
4. **PostgreSQL and Oracle.** Every SQL statement and every migration must work on both databases.
5. **Data access order:** model classes (`M*`) → `Query` → `DB.*` helpers → raw JDBC only when unavoidable (and always close resources).
6. **Backward compatibility.** Do not change or remove public method signatures; add an overload instead. Plugins depend on core APIs and on columns that look unused.
7. **English only** for code, identifiers and comments. New Java files get the GPLv2 license header.
8. **Minimal, focused diffs.** Touch only what the ticket needs. No drive-by reformatting, no unrelated cleanups.
9. **Honest testing.** Never claim a test passed if you did not run it. Say what was and was not verified.

## Skills

Detailed, task-specific instructions live in `.agents/skills/<name>/SKILL.md`. Read the matching skill **before** starting the task.

| When you are… | Read |
|---|---|
| Starting work on a ticket, branching, committing, opening or updating a pull request | `.agents/skills/idempiere-contribution-workflow/SKILL.md` |
| Writing or changing Java code in core | `.agents/skills/idempiere-core-coding-standards/SKILL.md` |
| Facing a change that needs new/changed tables, columns, windows, messages, references, processes or any `AD_*` record | `.agents/skills/idempiere-database-changes/SKILL.md` |
| Writing or running unit tests (`org.idempiere.test`) | `.agents/skills/idempiere-unit-tests/SKILL.md` |
| Building, syncing the database, starting the server from the terminal | `.agents/skills/idempiere-headless-build-run/SKILL.md` |
| Reviewing a pull request, or self-reviewing a diff before opening one | `.agents/skills/idempiere-pr-review/SKILL.md` |
| Drafting a Jira bug report or feature request | `.agents/skills/idempiere-jira-tickets/SKILL.md` |

## Repository orientation

- `org.adempiere.base/` — core model (`org.compiere.model`), utilities (`org.compiere.util`), processes, services.
- `org.adempiere.ui.zk/` — ZK web client.
- `org.idempiere.test/` — JUnit 5 tests run against a GardenWorld database.
- `migration/iD<version>/{postgresql,oracle}/` — migration scripts (generated, never hand-written by agents).
- `org.idempiere.parent/pom.xml` — Maven/Tycho build parent. Build with `./mvnw verify`.
- `RUN_SyncDBDev.sh` — applies pending migration scripts to the local database.
- `pull_request_template.md` — checklist every PR must satisfy.
