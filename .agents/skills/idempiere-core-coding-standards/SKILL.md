---
name: idempiere-core-coding-standards
description: Coding rules for iDempiere core Java code. Use whenever writing or modifying Java in the iDempiere core repository, especially code that reads or writes data (model classes, Query, DB, JDBC, SQL), touches transactions, changes public APIs, or adds new classes.
---

# iDempiere core coding standards

References:
- https://docs.idempiere.org/docs/basic-development/contributing-to-core/how-to-contribute
- https://docs.idempiere.org/docs/basic-development/contributing-to-core/common-issues

Before writing new code, read the surrounding code and match its style (tabs, brace placement, naming, comment density). Consistency with the file beats personal preference.

## 1. Data access: use this order of preference

1. **Model classes (`M*`)**: e.g. `MBPartner.get(ctx, id)`, `MOrder#getLines()`. Many have cached static getters; use them. For bulk changes on many POs, use `BatchUpdate` / `BatchInsert` / `BatchDelete` (`org.compiere.model`). They run the applicable save or delete hooks, validators and the change log, but `BatchInsert` skips `afterSave`, translations and tree nodes. See `references/data-access-examples.md`.
2. **`Query`**: `new Query(ctx, MOrder.Table_Name, whereClause, trxName)` with `.setParameters(...)`, `.setClient_ID()`, `.setOnlyActiveRecords(true)`, `.setOrderBy(...)`, then `.list()`, `.first()`, `.firstOnly()`, `.count()`.
3. **`DB` helpers**: `DB.getSQLValueEx(trxName, sql, params...)`, `DB.getSQLValueStringEx(...)`, `DB.executeUpdateEx(sql, params, trxName)`. A raw `UPDATE` bypasses `beforeSave`, model validators, event handlers and the change log, so use it only when that is intended.
4. **Raw JDBC** (`DB.prepareStatement`): only when nothing above fits, e.g. large streaming reads. Always close resources in `finally` with `DB.close(rs, pstmt)`.

See `references/data-access-examples.md` for the canonical patterns.

### SQL rules
- **Bind parameters** (`?`). Never concatenate user or record values into SQL.
- Use `Table_Name` and `COLUMNNAME_*` constants from the `X_*` / `I_*` classes rather than string literals where practical.
- SQL must run on **PostgreSQL and Oracle**. Avoid database-specific functions and syntax. Use helpers such as `DB.TO_DATE(...)`, and use `DB.isPostgreSQL()` / `DB.isOracle()` only as a last resort.
- Respect client/org security. In UI-facing queries use `MRole.getDefault().addAccessSQL(...)` where the surrounding code does.

## 2. Transactions and context

- Pass the current `trxName` all the way through (`get_TrxName()` inside a PO, the process `get_TrxName()` in a `SvrProcess`). Don't use `null` when a transaction is active, or you'll read stale data or cause locks.
- Don't commit or rollback a transaction you didn't create.
- Use `Env.getCtx()` / `getCtx()`. Don't build contexts by hand.

## 3. Model class (PO) conventions

- Business validation goes in `beforeSave` / `afterSave` / `beforeDelete`. To reject, `log.saveError("Error", Msg.getMsg(getCtx(), "MessageKey"))` and return `false`.
- User-facing text goes through `AD_Message` (`Msg.getMsg`, `Msg.translate`, `Msg.getElement`). Never hard-code user-visible strings. A new message needs an `AD_Message` record, which the **developer** creates (see `idempiere-database-changes`).
- Throw `AdempiereException` (or a subclass) for runtime errors, with a translated message where users see it.
- Log with `CLogger` at the right level. Don't use `System.out` / `printStackTrace` in production code.
- `X_*` and `I_*` classes are generated. Never edit them by hand; the developer regenerates them after dictionary changes.

## 4. Backward compatibility

- **Prefer overloads over changing or removing a public or protected method signature.** Add the new signature and have the old one delegate to it. Plugins compile against core. Change or remove a signature only when the developer explicitly decides on a breaking change; then it must be documented as one (PR template "Breaking change" and the migration notes in the docs).
- Deprecate with `@Deprecated` plus javadoc pointing to the replacement, instead of deleting.
- If you change the signature of a class or interface (e.g. add, remove or change public methods or fields), regenerate its `serialVersionUID` if it has one. This is the project convention (see How to Contribute), even for changes Java considers serialization-compatible.
- Columns and fields that look "unused" may be used by implementers. Don't remove them or change their meaning.
- Changing default behavior needs a strong reason. Prefer an opt-in (e.g. an `AD_SysConfig` key, which the developer creates) and mention it in the PR.

## 5. Code quality

- **English only** for identifiers, comments and messages.
- Meaningful names, camelCase, Java conventions.
- Comment non-obvious logic. If code needs many comments, improve the names or structure instead.
- **New Java files** start with the GPLv2 license header used across the repo. Copy it from an existing file such as `org.idempiere.test/src/org/idempiere/test/AbstractTestCase.java` and adjust the contributor line.
- Add `@Override` and javadoc on new public methods.
- No new compiler warnings. No unused imports.
- Keep the diff minimal: no reformatting of untouched lines, no unrelated renames, no mixing refactoring with the fix (separate commits, see `idempiere-contribution-workflow`).
- Don't add a new third-party dependency without discussing it with the developer. It affects the OSGi target platform and licensing.

## 6. Collateral impact analysis (required, even for one-line changes)

Before you consider a change done:

1. Find every caller of each method or class you changed (search the whole repo, including `org.adempiere.ui.zk`, `org.adempiere.base.process`, `org.idempiere.test`).
2. Ask whether the change alters behavior for any of those callers, for other document types, for multi-currency or multi-schema accounting, for other clients or orgs, for Oracle.
3. List the affected scenarios in the PR description (see `idempiere-contribution-workflow`).

## 7. Security

- No SQL injection (bind parameters), no exposing data across clients or orgs, no bypassing role access.
- Don't log passwords, tokens or personal data.
- Validate inputs that come from the UI, REST or imports.
- If you spot a vulnerability, don't describe it in a public PR or ticket. See `idempiere-jira-tickets` for the private reporting path.
