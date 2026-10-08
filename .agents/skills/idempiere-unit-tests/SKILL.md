---
name: idempiere-unit-tests
description: Writing and running iDempiere core unit tests in org.idempiere.test (JUnit 5 + Tycho, against a GardenWorld database). Use when adding a test for a bug fix or new feature, choosing where a test goes, using AbstractTestCase or DictionaryIDs, or running one test or the whole suite from the terminal.
---

# iDempiere unit tests

Core tests live in the `org.idempiere.test` bundle. They are **integration-style JUnit 5 tests** that run inside OSGi against a real iDempiere database with GardenWorld seed data. A configured local database (via `idempiere.properties` in the repo root) is required.

## When a test is expected

- A **bug fix** should come with a test that fails before the fix and passes after, whenever the logic can be exercised without the UI.
- **New business logic** (model classes, processes, accounting, costing, utilities) should have tests.
- UI-only (ZK) changes usually aren't unit-tested. Describe manual tests in the PR instead.
- All **existing** tests must still pass before opening the PR.

## Where to put the test

Package by area under `org.idempiere.test/src/org/idempiere/test/`:

| Package | For |
|---|---|
| `base` | Core utilities, documents (`InOutTest`, `InvoiceTest`, `EnvTest`, `DBTest`…) |
| `model` | Model classes, callouts, allocations, bank statements… |
| `acct`, `costing` | Posting and costing (use `assertFactAcctEntries` helpers) |
| `process`, `workflow`, `event`, `form`, `print`, `ui`, `dashboard`… | Respective areas |

Prefer adding a method to an existing test class for the same model or feature. Name new classes `<Subject>Test`.

## How to write one

Extend `AbstractTestCase`. It gives each test method:

- a logged-in **GardenWorld Admin** context (client, HQ org, admin user/role, HQ warehouse, `en_US`);
- a fresh transaction, available via `getTrxName()`, that is **rolled back** after each test, so tests don't leave data behind. Pass `getTrxName()` to every model constructor, `Query` and `DB` call;
- helpers `getAD_Client_ID()`, `getAD_Org_ID()`, `getLoginDate()`, `commit()`, `rollback()`, `assertFactAcctEntries(...)`.

Reference existing records through `DictionaryIDs` (e.g. `DictionaryIDs.C_BPartner.JOE_BLOCK.id`, `DictionaryIDs.M_Product.AZALEA_BUSH.id`) instead of magic numbers. If you need a record that isn't there yet, add an enum constant with the **real** ID and UUID looked up from the GardenWorld database. Never invent IDs (see `idempiere-database-changes`).

See `references/test-template.java` for a skeleton.

Guidelines:
- Make tests deterministic: no dependency on the current date unless set explicitly, no reliance on test order.
- Complete or void documents with `MWorkflow.runDocumentActionWorkflow(po, DocAction.ACTION_Complete)`, as the UI does. Assert `assertFalse(info.isError(), info.getSummary())` on the returned `ProcessInfo`, then `po.load(getTrxName())` before checking the status.
- Read existing records with the cached getters (`MBPartner.get(Env.getCtx(), id)`) when the test only reads them.
- Avoid `commit()` unless the code under test truly needs committed data. If you commit, clean up afterwards.
- Assert the specific outcome with a helpful message: `assertEquals(expected, actual, "why")`.
- Use the GPLv2 header on new test files.
- Mockito (`mockStatic`, etc.) is available and used in existing tests when needed.

## Running tests from the terminal

Tests are skipped by default (`skipTests=true` in `org.idempiere.test/pom.xml`). Enable them explicitly:

```bash
# whole build plus the full test suite (slow)
./mvnw verify -DskipTests=false

# a single test class (Tycho surefire honours -Dtest)
./mvnw verify -DskipTests=false -Dtest=InOutTest

# a single method
./mvnw verify -DskipTests=false -Dtest='InOutTest#testMatShipmentPosting'
```

- Test runs use `idempiere.home=..` (the repo root), so `idempiere.properties` there must point to a working database with migrations applied (`bash RUN_SyncDBDev.sh`).
- Results: `org.idempiere.test/target/surefire-reports/`.
- In Eclipse, developers use `org.idempiere.test/idempiere.unit.test.launch`.
- A full run takes a long time. While iterating, run the affected class. Run the whole suite before the PR, or tell the developer it wasn't run.

## Reporting

In the PR description, list the tests added or updated and the exact command used to run them, with the result. If the suite wasn't run or a test was already failing on `master`, say so explicitly. Never report tests as passing without having run them.
