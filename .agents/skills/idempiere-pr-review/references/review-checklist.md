# iDempiere core review checklist

## Scope and process
- [ ] PR body starts with the Jira link. Commits are `IDEMPIERE-#### ...`.
- [ ] One ticket, one purpose. No unrelated files. Refactoring in a separate commit.
- [ ] Branch isn't `master`. No IDE or local files committed (`idempiere.properties`, `.classpath`, `jettyhome/`, `target/`, logs).
- [ ] Documentation needed (new feature, breaking change, user-visible improvement)? A docs PR is linked, or the reason it's not needed is given.

## Database
- [ ] SQL works on PostgreSQL **and** Oracle (no `LIMIT`, `ROWNUM`, `::cast`, `ILIKE`, DB-specific functions without a helper).
- [ ] Dictionary or schema changes come with generated migration scripts in both `postgresql/` and `oracle/`, named `yyyyMMddHHmm_IDEMPIERE-####.sql`, with `register_migration_script`.
- [ ] Scripts contain only this ticket's statements, no failed or trial-and-error statements, and use Centralized IDs.
- [ ] `X_*` / `I_*` classes regenerated (not hand-edited) when columns changed.

## Data access
- [ ] Preference order respected: model class → `Query` → `DB.*` → JDBC.
- [ ] Bind parameters everywhere. No string-concatenated values.
- [ ] JDBC resources closed in `finally` with `DB.close(rs, pstmt)`.
- [ ] `trxName` passed through. No `null` trx inside a transaction. No commits or rollbacks of transactions the code doesn't own.
- [ ] No N+1 queries in loops over large sets. Caches (`MXxx.get`) used where appropriate.

## API and compatibility
- [ ] No public or protected signature removed or changed. Exception: an intentional breaking change, explicitly declared by the PR author and documented in the PR and the migration notes, and reported as a finding for the human reviewer or maintainers to accept. New overloads delegate correctly.
- [ ] `serialVersionUID` regenerated if the signature of a serializable class changed (project convention, see How to Contribute).
- [ ] Default behavior unchanged, or the change is justified and documented (opt-in via SysConfig preferred).
- [ ] No removal or repurposing of columns that look "unused".

## Code quality
- [ ] English identifiers, comments and messages. User-visible text via `AD_Message` / `Msg`.
- [ ] GPLv2 header on new Java files.
- [ ] No new compiler warnings or unused imports. Matches surrounding style.
- [ ] Non-obvious logic is commented. Names are meaningful.
- [ ] Exceptions aren't swallowed. Logging through `CLogger` at the right level.

## Security
- [ ] No SQL injection, XSS in ZK output, path traversal or unsafe deserialization.
- [ ] Role and client/org access respected (`MRole.addAccessSQL` where applicable).
- [ ] No credentials, tokens or personal data logged.

## Tests and collateral
- [ ] Unit test added or updated for logic changes (fails before, passes after), or a reason it isn't feasible.
- [ ] Existing tests pass (command and result stated).
- [ ] Callers of changed methods reviewed. Other doc types, multi-currency, multi-acct-schema, other clients considered.
- [ ] Manual test scenarios listed, including non-happy paths.
