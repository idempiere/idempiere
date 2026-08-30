# IDEMPIERE-7089 Implementation Proposal

## Ticket

[IDEMPIERE-7089: Audit remaining locale-dependent Java case conversions outside IDEMPIERE-7082](https://idempiere.atlassian.net/browse/IDEMPIERE-7089)

## Objective

Remove unintended dependencies on `Locale.getDefault()` from Java case conversion while preserving the correct semantics for database values, technical tokens, SQL/schema identifiers, user-facing text, and domain-specific values.

This must be a semantic migration. It must not be implemented as a global replacement of every parameterless `toUpperCase()` or `toLowerCase()` call with `Locale.ROOT`.

## Baseline and Scope Boundary

The implementation branch is based on `upstream/master` at commit:

```text
28acd37703
```

At this commit, tracked Java sources contain 460 parameterless case-conversion locations. This differs from the 410 locations visible on the original IDEMPIERE-7082 PR branch because PR #3332 has not yet been merged into `master` and because `master` has evolved since that PR branch was created.

The original ticket baseline is:

- 460 classified locations in total;
- 52 locations classified as `IDEMPIERE_7082_HANDLED` and excluded from IDEMPIERE-7089;
- 408 locations in scope for IDEMPIERE-7089.

The 52 excluded locations consist of 50 conversions that PR #3332 removes and two compatibility-sensitive conversions that it deliberately retains. IDEMPIERE-7089 must not modify any of them.

The current `master` delta is:

- two original `TECH_TOKEN` locations have already been removed or corrected independently;
- three new `TECH_TOKEN` locations have been introduced;
- the active IDEMPIERE-7089 implementation scope is therefore 409 locations;
- the active `TECH_TOKEN` implementation scope is 66 locations.

Before an IDEMPIERE-7089 pull request is finalized, the branch should be rebased after PR #3332 is merged. Until then, reviews and automated scans must subtract the 52 `IDEMPIERE_7082_HANDLED` locations from the raw `master` result.

## Delivery Strategy

IDEMPIERE-7089 will be delivered in one draft pull request. The current 409-location scope remains divided into six internal implementation phases so that database behavior, technical normalization, UI behavior, domain decisions, and maintenance code remain separately reviewable within the same pull request.

The current `workspace/IDEMPIERE-7089` branch is the single draft pull request. Its WIP commits are organized according to the six phases below; the initial code commit implements Phase 1 and the remaining locations carry explicit phase markers until their implementation is completed.

During the draft stage, affected source locations are marked with compact comments that preserve the originally proposed pull-request grouping:

- `// IDEMPIERE-7089-P1` — `DB_VALUE`
- `// IDEMPIERE-7089-P2` — `TECH_TOKEN`
- `// IDEMPIERE-7089-P3` — `DB_SCHEMA_SQL`
- `// IDEMPIERE-7089-P4` — `USER_TEXT`
- `// IDEMPIERE-7089-P5` — `DOMAIN`
- `// IDEMPIERE-7089-P6` — `TEST`, `VENDORED`, and `INERT`

The comments are work-in-progress markers. Each marker must be replaced by the final implementation or an explicit source-level justification before the draft is marked ready for review.

### Phase 1: Database Value Comparisons

Implement the 14 high-priority `DB_VALUE` locations. Each currently applies `UPPER(...)` to the database expression but applies Java `toUpperCase()` to the value. The proposed change is:

```sql
-- Before
UPPER(column_name) = ?
```

```java
statement.setString(index, value.toUpperCase());
```

```sql
-- After
UPPER(column_name) = UPPER(?)
```

```java
statement.setString(index, value);
```

This delegates both mappings to the same database engine, removes dependence on the JVM default locale, and preserves the existing case-insensitive equality contract.

#### Proposed Source Changes

1. `org.adempiere.base/src/org/compiere/model/MColumn.java`
   - Change both foreign-key constraint-name duplicate checks to `UPPER(FkConstraintName)=UPPER(?)`.
   - Bind `fkConstraintName` without Java case conversion.

2. `org.adempiere.base/src/org/compiere/model/MQuery.java`
   - Change the `AD_Column.ColumnName` lookup to `UPPER(ColumnName)=UPPER(?)`.
   - Pass `ParameterName` unchanged.

3. `org.adempiere.base/src/org/compiere/model/MSearchDefinition.java`
   - Change both transaction-code lookups to `UPPER(TransactionCode)=UPPER(?)`.
   - Bind `transactionCode` unchanged.

4. `org.adempiere.base/src/org/compiere/model/M_Element.java`
   - Change the static element lookup and duplicate check to normalize both SQL operands.
   - Bind `columnName` unchanged.
   - In the dynamically constructed `AD_Process_Para` update, apply database `UPPER(...)` to the quoted original value instead of applying Java `toUpperCase()` before quoting it.

5. `org.adempiere.base/src/org/compiere/util/Msg.java`
   - Change both base-language and translated element queries to `UPPER(ColumnName)=UPPER(?)`.
   - Bind `ColumnName` unchanged.

6. `org.adempiere.pipo/src/org/adempiere/pipo2/IDFinder.java`
   - For all three `ignoreCase` paths, generate `UPPER(column)=UPPER(?)`.
   - Preserve decoded and direct values without Java case conversion.
   - Preserve the case-sensitive paths unchanged.

7. `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/DocumentSearchController.java`
   - Change the transaction-code predicate to `UPPER(TransactionCode)=UPPER(?)`.
   - Pass `transactionCode` unchanged.

8. `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/info/InfoWindow.java`
   - Change the `AD_Column.ColumnName` metadata lookup to `UPPER(ColumnName)=UPPER(?)`.
   - Pass `column` unchanged.

#### Phase 1 Non-Goals

- Do not modify any of the 52 `IDEMPIERE_7082_HANDLED` locations.
- Do not add `Locale.ROOT` to database-bound values.
- Do not change equality to `LIKE`, wildcard handling, or accent behavior.
- Do not introduce database-specific functions.
- Do not address the 264 `DB_SCHEMA_SQL` or 66 active `TECH_TOKEN` locations in this phase.
- Do not change user-facing text or domain-value semantics.

#### Phase 1 Tests

Add focused integration tests that:

- set the JVM default locale to `tr-TR` and restore it in `finally` or test cleanup;
- prevent parallel execution while the global default locale is changed;
- verify a public lookup containing the ASCII letter `i`, for example an `M_Element` column-name lookup, using a differently cased input;
- verify that the lookup result is identical under `Locale.ROOT`, `en-US`, `de-DE`, and `tr-TR`;
- verify a database value containing `ß` where a suitable isolated test record can be created;
- execute on both PostgreSQL and Oracle;
- confirm that case-sensitive `IDFinder` paths remain case-sensitive;
- confirm that transaction-code and column-name equality semantics are unchanged.

The test must restore the original default locale even when an assertion or database operation fails. Because `Locale.setDefault(...)` changes global JVM state, the test must use the test suite's global resource lock or an equivalent serialization mechanism.

#### Phase 1 Validation

```bash
git grep -n -E '\.to(Lower|Upper)Case\(\)' -- '*.java'
git diff --check
mvn -pl org.idempiere.test verify
```

The exact Maven module selection may be narrowed during implementation if the repository's Tycho setup requires a different invocation, but the final verification must exercise the affected base, PIPO, and ZK code paths.

## Subsequent Phases in the Same Pull Request

### Phase 2: Technical Tokens

Scope: 66 active `TECH_TOKEN` locations, including three additions and excluding two locations already resolved independently on `master`.

Use the following decision order:

1. Prefer `equalsIgnoreCase()` for equality checks.
2. Prefer `regionMatches(true, ...)` or a focused helper for case-insensitive prefix/suffix checks when it improves clarity.
3. Use `Locale.ROOT` when a normalized string is required for a map key, enum conversion, protocol token, file extension, path, MIME value, CSS/OSGi value, or similar language-independent value.
4. Use an explicitly ASCII-specific implementation only where the protocol or file format defines ASCII semantics and the code benefits from enforcing that contract.

Group changes by module and add Turkish-default-locale tests for protocols, paths, file extensions, MIME values, and internal keys.

### Phase 3: SQL and Schema Mechanics

Scope: 264 `DB_SCHEMA_SQL` locations.

These are high-confidence technical strings but form the largest category. Split them further by subsystem if necessary:

- SQL conversion and parsing;
- Oracle identifier handling;
- PostgreSQL identifier handling;
- application-dictionary table and column handling;
- model and migration code generation;
- metadata, constraint, sequence, index, and partition names.

Prefer structural metadata or parser APIs where available. Otherwise use `Locale.ROOT` for unavoidable Java normalization of SQL keywords and identifiers. Preserve the explicit Oracle-uppercase and PostgreSQL-lowercase identifier conventions.

### Phase 4: User-Facing Text

Scope: 37 `USER_TEXT` locations.

Do not implement this category until the expected product behavior is confirmed. For each location, decide whether comparison follows:

- the login/user locale;
- Unicode case-insensitive comparison;
- a `Collator` with a documented strength;
- database collation;
- accent-normalized search already defined by that subsystem; or
- exact case-sensitive behavior.

Menu search, autocomplete, document search, city search, and extension-manager search should be treated as separate behavior groups. `Locale.ROOT` is not the default answer for natural-language text.

### Phase 5: Domain-Specific Values

Scope: 11 `DOMAIN` locations.

Document the normalization contract for every value type before changing code. Likely dispositions include:

- IBAN: explicit locale-neutral uppercase canonicalization;
- fixed-asset and account keys: explicit technical-key normalization;
- unit codes: follow the code-system specification;
- email/preferred username: define equality semantics before changing behavior;
- Web Store context: define whether it is a path, identifier, or user-configurable value.

Do not combine unresolved domain decisions with mechanical technical-token changes.

### Phase 6: Tests and Maintenance Sources

Scope: 9 `TEST`, 5 `VENDORED`, and 3 `INERT` locations.

- Update test conversions to match the production strategy they verify.
- Set locales explicitly in locale-sensitive tests.
- Do not modify embedded third-party or historical migration code without an explicit maintenance decision.
- Remove commented-out occurrences only as non-functional cleanup.

## Implementation Rules

Every changed location must receive one explicit disposition:

- `DB_BOTH_OPERANDS`
- `LOCALE_ROOT`
- `CASE_INSENSITIVE_API`
- `USER_LOCALE_OR_COLLATOR`
- `DOMAIN_SPECIFIC`
- `TEST_ONLY`
- `VENDORED_OR_HISTORIC`
- `INERT`

The companion classification should be updated with the selected disposition and the implementing PR for every completed location. This provides an auditable path from the original 460-location inventory to the final code.

## Review and Compatibility Requirements

- Preserve all public and protected API signatures unless separately approved.
- Preserve PR #3332's compatibility decisions, including `PO.getFindParameter(String)` and the authorization-code handling in `StatementCreateFromBatch`.
- Keep prepared-statement binding; do not concatenate user values into SQL.
- Verify PostgreSQL and Oracle behavior for database changes.
- Review query plans where a change adds or moves a SQL function. In Phase 1, the indexed column expression remains unchanged and only the parameter gains the matching function.
- Preserve existing ASCII behavior unless a deliberate correction is documented.
- Do not include accent-insensitive search or global collation changes.
- Avoid tests that leak a changed JVM default locale into other tests.

## Proposed Definition of Done

IDEMPIERE-7089 is complete when:

1. all 52 `IDEMPIERE_7082_HANDLED` locations remain excluded;
2. each of the 409 currently active in-scope locations has a reviewed final disposition;
3. all approved first-party changes are implemented in one pull request with semantically grouped phases and commits;
4. technical normalization no longer depends unintentionally on `Locale.getDefault()`;
5. database-value comparisons apply the same database function to both operands;
6. user-text and domain behavior follow explicitly documented policies;
7. PostgreSQL and Oracle validation succeeds where applicable;
8. locale tests cover at least `Locale.ROOT`, `en-US`, `de-DE`, and `tr-TR`;
9. the classification records the implementing PR or follow-up decision for every location; and
10. remaining product or compatibility decisions have dedicated follow-up tickets.
