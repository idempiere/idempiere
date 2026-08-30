# IDEMPIERE-7082: Semantic Classification of Parameterless Case Conversions

Baseline: commit `cae980e45dfb3d685594c326f2c00ab6b6c26160`

## Scope and Method

Inventory of all locations in tracked Java sources that use parameterless `.toUpperCase()` or `.toLowerCase()`. The inventory was generated with:

```bash
git grep -n -E '\.to(Lower|Upper)Case\(\)' -- '*.java'
```

The current PR state contains 410 remaining matches in 139 files. An additional 50 Java case conversions already removed by IDEMPIERE-7082 were reconstructed from the PR diff. Together with the two compatibility-sensitive locations deliberately retained in the PR, the classification covers 460 locations in 155 files. `H` means high confidence and `M` means medium confidence. Medium confidence identifies locations where the intended domain-specific or linguistic semantics must be confirmed before making a change.

Important: This document is a basis for making decisions, not a recommendation for a mass replacement. User-facing text, database comparisons, and compatibility-sensitive APIs require different strategies.

The original classification baseline is preserved below. A current `upstream/master` addendum near the end of this document records two locations resolved independently and three newly introduced locations. Consequently, the current IDEMPIERE-7089 implementation scope contains 409 active locations rather than the original 408.

In the IDEMPIERE-7089 draft pull request, active source locations are marked with `// IDEMPIERE-7089-P1` through `// IDEMPIERE-7089-P6`. These markers identify the former planned PR groups while all work is now delivered in one pull request.

## Summary

| Code | Category | Count | Recommended Direction |
|---|---|---:|---|
| IDEMPIERE_7082_HANDLED | Handled separately by IDEMPIERE-7082 | 52 | Exclude from the new Jira scope; complete PR #3332 separately. |
| DB_VALUE | Database value comparison | 14 | Bind the original value and apply the same database function to both operands. |
| DB_SCHEMA_SQL | SQL/schema mechanics | 264 | Use `Locale.ROOT` or structural APIs; do not normalize SQL values differently in Java and the database. |
| TECH_TOKEN | Technical token | 65 | Use `Locale.ROOT`, `equalsIgnoreCase()`, or an explicitly ASCII-specific strategy. |
| USER_TEXT | User-facing text/UI search | 37 | Use an explicit login/user locale or `Collator`; do not apply `Locale.ROOT` indiscriminately. |
| DOMAIN | Domain-specific canonicalization | 11 | Decide and document the strategy for each value type; for example, normalize IBAN values explicitly in a locale-neutral way. |
| TEST | Test code | 9 | Set the locale explicitly in the test or verify the exact production strategy. |
| VENDORED | Historic/vendored code | 5 | Do not make an isolated change without a maintenance or upgrade decision. |
| INERT | Inactive comment | 3 | No runtime change is required; clean up when appropriate. |
|  | **Total** | **460** | 52 are handled separately by IDEMPIERE-7082, leaving 408 to be evaluated under the new Jira ticket. |

## Classification Rules

- **IDEMPIERE_7082_HANDLED – Handled separately by IDEMPIERE-7082:** Java/database mismatches removed by PR #3332 and two deliberately preserved compatibility locations. Exclude these from the new Jira scope and handle them exclusively in the existing PR.
- **DB_VALUE – Database value comparison:** A parameter transformed with Java case mapping is compared with `UPPER(...)` or `LOWER(...)` in SQL. Bind the original value and apply the same database function to both operands.
- **DB_SCHEMA_SQL – SQL/schema mechanics:** SQL grammar, table/column/index names, and database metadata. Use `Locale.ROOT` or structural APIs; do not normalize SQL values differently in Java and the database.
- **TECH_TOKEN – Technical token:** Protocols, paths, file extensions, class/property names, CSS/OSGi values, and internal keys. Use `Locale.ROOT`, `equalsIgnoreCase()`, or an explicitly ASCII-specific strategy.
- **USER_TEXT – User-facing text/UI search:** Natural-language labels, search text, and autocomplete comparisons. Use an explicit login/user locale or `Collator`; do not apply `Locale.ROOT` indiscriminately.
- **DOMAIN – Domain-specific canonicalization:** Business or configuration values with their own normalization contract. Decide and document the strategy for each value type; for example, normalize IBAN values explicitly in a locale-neutral way.
- **TEST – Test code:** Locale-dependent transformations in tests. Set the locale explicitly in the test or verify the exact production strategy.
- **VENDORED – Historic/vendored code:** Migration history or embedded third-party source. Do not make an isolated change without a maintenance or upgrade decision.
- **INERT – Inactive comment:** The match exists only in commented-out code. No runtime change is required; clean up when appropriate.

## Complete Classification

### IDEMPIERE_7082_HANDLED – Already Handled Separately by IDEMPIERE-7082 (52)

These entries belong to PR #3332 and are explicitly excluded from the follow-up Jira ticket. The first 50 references refer to the PR base version; these Java-side conversions were removed and the relevant comparisons were changed to use consistent database-side normalization. The final two entries are current compatibility-sensitive locations whose behavior was deliberately retained and reviewed in the same PR.

#### Removed Java-Side Search Conversions (50)

- **H** — `org.adempiere.base.process/src/org/compiere/process/InventoryCountCreate.java:213` *(PR base)* — `pstmt.setString(index++, p_LocatorValue.toUpperCase());`
- **H** — `org.adempiere.base.process/src/org/compiere/process/InventoryCountCreate.java:215` *(PR base)* — `pstmt.setString(index++, p_ProductValue.toUpperCase());`
- **H** — `org.adempiere.base/src/org/compiere/model/MLabel.java:182` *(PR base)* — `.setParameters(Env.getAD_Client_ID(ctx), name.toUpperCase())`
- **H** — `org.adempiere.base/src/org/compiere/model/MUserQuery.java:246` *(PR base)* — `pstmt.setString (3, name.toUpperCase());`
- **H** — `org.adempiere.base/src/org/compiere/model/MUserQuery.java:277` *(PR base)* — `.setParameters(Env.getAD_Client_ID (ctx), AD_Tab_ID, name.toUpperCase(), Env.getAD_User_ID(ctx))`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/editor/WAccountEditor.java:198` *(PR base)* — `pstmt.setString(2, text.toUpperCase());`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/editor/WAccountEditor.java:199` *(PR base)* — `pstmt.setString(3, text.toUpperCase());`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/editor/WLocatorEditor.java:382` *(PR base)* — `text = text.toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/editor/WLocatorEditor.java:384` *(PR base)* — `text = text.toUpperCase() + "%";`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoAssetPanel.java:291` *(PR base)* — `String value = fieldValue.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoAssetPanel.java:298` *(PR base)* — `String name = fieldName.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoAssetPanel.java:341` *(PR base)* — `String value = fieldValue.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoAssetPanel.java:354` *(PR base)* — `String name = fieldName.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoBPartnerPanel.java:381` *(PR base)* — `String value = fieldValue.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoBPartnerPanel.java:390` *(PR base)* — `String name = fieldName.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoBPartnerPanel.java:399` *(PR base)* — `String contact = fieldContact.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoBPartnerPanel.java:408` *(PR base)* — `String email = fieldEMail.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoBPartnerPanel.java:417` *(PR base)* — `String phone = fieldPhone.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoBPartnerPanel.java:426` *(PR base)* — `String postal = fieldPostal.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoBPartnerPanel.java:448` *(PR base)* — `String value = fieldValue.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoBPartnerPanel.java:452` *(PR base)* — `String name = fieldName.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoBPartnerPanel.java:456` *(PR base)* — `String contact = fieldContact.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoBPartnerPanel.java:460` *(PR base)* — `String email = fieldEMail.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoBPartnerPanel.java:464` *(PR base)* — `String phone = fieldPhone.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoBPartnerPanel.java:468` *(PR base)* — `String postal = fieldPostal.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoCashLinePanel.java:482` *(PR base)* — `String s = f.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoGeneralPanel.java:685` *(PR base)* — `addSQLWhere (sql, 0, txt1.getText().toUpperCase());`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoGeneralPanel.java:686` *(PR base)* — `addSQLWhere (sql, 1, txt2.getText().toUpperCase());`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoGeneralPanel.java:687` *(PR base)* — `addSQLWhere (sql, 2, txt3.getText().toUpperCase());`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoGeneralPanel.java:688` *(PR base)* — `addSQLWhere (sql, 3, txt4.getText().toUpperCase());`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoGeneralPanel.java:708` *(PR base)* — `String s = f.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoInOutPanel.java:420` *(PR base)* — `String s = f.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoInvoicePanel.java:550` *(PR base)* — `String s = f.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoOrderPanel.java:513` *(PR base)* — `String s = f.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoPaymentPanel.java:481` *(PR base)* — `String s = f.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoProductPanel.java:1048` *(PR base)* — `String value = fieldValue.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoProductPanel.java:1053` *(PR base)* — `String name = fieldName.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoProductPanel.java:1058` *(PR base)* — `String upc = fieldUPC.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoProductPanel.java:1063` *(PR base)* — `String sku = fieldSKU.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoProductPanel.java:1067` *(PR base)* — `String vendor = fieldVendor.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoProductPanel.java:1128` *(PR base)* — `String value = fieldValue.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoProductPanel.java:1138` *(PR base)* — `String name = fieldName.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoProductPanel.java:1148` *(PR base)* — `String upc = fieldUPC.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoProductPanel.java:1158` *(PR base)* — `String sku = fieldSKU.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoProductPanel.java:1168` *(PR base)* — `String vendor = fieldVendor.getText().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/window/FindWindow.java:3029` *(PR base)* — `StringBuilder valueStr = new StringBuilder(value.toString().toUpperCase());`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/window/WAccountDialog.java:859` *(PR base)* — `String value = f_Alias.getValue().toString().toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/window/WAccountDialog.java:867` *(PR base)* — `String value = f_Combination.getValue().toString().toUpperCase();`
- **H** — `org.adempiere.ui/src/org/compiere/apps/form/StatementCreateFromBatch.java:201` *(PR base)* — `String s = text.toUpperCase();`
- **H** — `org.adempiere.ui/src/org/compiere/grid/CreateFromBatch.java:231` *(PR base)* — `String s = text.toUpperCase();`

#### Deliberately Retained Compatibility Behavior (2)

- **H** — `org.adempiere.base/src/org/compiere/model/PO.java:5763` *(current PR state)* — `return query.toUpperCase();` — Protected legacy helper retained for plugin compatibility and marked as deprecated.
- **H** — `org.adempiere.ui/src/org/compiere/apps/form/StatementCreateFromBatch.java:163` *(current PR state)* — `pstmt.setString(index++, getSQLText(AuthCode).toUpperCase());` — Existing behavior for authorization codes retained after changing the shared helper.


### DB_VALUE – Database Value Comparison (14)

A parameter transformed with Java case mapping is compared with `UPPER(...)` or `LOWER(...)` in SQL. Recommendation: bind the original value and apply the same database function to both operands.

- **H** — `org.adempiere.base/src/org/compiere/model/MColumn.java:1315` — `int duplicateId = DB.getSQLValueEx(column.get_TrxName(), "SELECT AD_Column_ID FROM AD_Column WHERE Upper(FkConstraintName)=?", fkConstraintName.toUpperCase());`
- **H** — `org.adempiere.base/src/org/compiere/model/MColumn.java:1324` — `duplicateId = DB.getSQLValueEx(column.get_TrxName(), "SELECT AD_Column_ID FROM AD_Column WHERE Upper(FkConstraintName)=?", fkConstraintName.toUpperCase());`
- **H** — `org.adempiere.base/src/org/compiere/model/MQuery.java:198` — `int cnt = DB.getSQLValueEx(null, "SELECT Count(*) From AD_Column WHERE IsActive='Y' AND AD_Client_ID=0 AND Upper(ColumnName)=? AND AD_Reference_ID=?", ParameterName.toUpperCase(), DisplayType.ChosenMultipleSelectionList);`
- **H** — `org.adempiere.base/src/org/compiere/model/MSearchDefinition.java:107` — `pstmt.setString(1, transactionCode.toUpperCase());`
- **H** — `org.adempiere.base/src/org/compiere/model/MSearchDefinition.java:145` — `pstmt.setString(1, transactionCode.toUpperCase());`
- **H** — `org.adempiere.base/src/org/compiere/model/M_Element.java:101` — `.setParameters(columnName.toUpperCase())`
- **H** — `org.adempiere.base/src/org/compiere/model/M_Element.java:197` — `int no = DB.getSQLValue(null, sql.toString(), columnName.toUpperCase());`
- **H** — `org.adempiere.base/src/org/compiere/model/M_Element.java:250` — `.append(DB.TO_STRING(getColumnName().toUpperCase()))`
- **H** — `org.adempiere.base/src/org/compiere/util/Msg.java:593` — `pstmt.setString(1, ColumnName.toUpperCase());`
- **H** — `org.adempiere.pipo/src/org/adempiere/pipo2/IDFinder.java:113` — `paramList.add(s.toUpperCase());`
- **H** — `org.adempiere.pipo/src/org/adempiere/pipo2/IDFinder.java:127` — `params = new Object[]{ ((String)value).toUpperCase()};`
- **H** — `org.adempiere.pipo/src/org/adempiere/pipo2/IDFinder.java:344` — `pstmt.setString(1, name.toUpperCase());`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/DocumentSearchController.java:681` — `query.setParameters(transactionCode.toUpperCase());`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/info/InfoWindow.java:1449` — `int cnt = DB.getSQLValueEx(null, "SELECT Count(*) From AD_Column WHERE IsActive='Y' AND AD_Client_ID=0 AND Upper(ColumnName)=? AND AD_Reference_ID=?", column.toUpperCase(), DisplayType.ChosenMultipleSelectionList);`

### DB_SCHEMA_SQL – SQL/Schema Mechanics (264)

SQL grammar, table/column/index names, and database metadata. Recommendation: use `Locale.ROOT` or structural APIs; do not normalize SQL values differently in Java and the database.

- **H** — `org.adempiere.base.process/src/org/compiere/process/ColumnSync.java:123` — `tableName = tableName.toUpperCase();`
- **H** — `org.adempiere.base.process/src/org/compiere/process/ColumnSync.java:127` — `tableName = tableName.toLowerCase();`
- **H** — `org.adempiere.base.process/src/org/compiere/process/CreateFromInOut.java:150` — `if (ColumnName.toUpperCase().endsWith("_ID"))`
- **H** — `org.adempiere.base.process/src/org/compiere/process/CreateFromInvoice.java:148` — `if (ColumnName.toUpperCase().endsWith("_ID"))`
- **H** — `org.adempiere.base.process/src/org/compiere/process/CreateFromRMA.java:140` — `if (ColumnName.toUpperCase().endsWith("_ID"))`
- **H** — `org.adempiere.base.process/src/org/compiere/process/CreateWindowFromTable.java:193` — `if (table.getTableName().toLowerCase().endsWith("_trl")) {`
- **H** — `org.adempiere.base.process/src/org/compiere/process/TableCreateColumns.java:114` — `tableName = tableName.toUpperCase();`
- **H** — `org.adempiere.base.process/src/org/compiere/process/TableCreateColumns.java:117` — `tableName = tableName.toLowerCase();`
- **H** — `org.adempiere.base.process/src/org/compiere/process/TableCreateColumns.java:167` — `String tn = tableName.toUpperCase();`
- **H** — `org.adempiere.base.process/src/org/compiere/process/TableCreateColumns.java:195` — `tableName = tableName.toUpperCase();`
- **H** — `org.adempiere.base.process/src/org/compiere/process/TableCreateColumns.java:198` — `tableName = tableName.toLowerCase();`
- **H** — `org.adempiere.base.process/src/org/compiere/process/TableCreateColumns.java:288` — `else if (columnName.toUpperCase().endsWith ("_ID"))`
- **H** — `org.adempiere.base.process/src/org/compiere/process/TableCreateColumns.java:348` — `|| columnName.toUpperCase().startsWith("CREATED")`
- **H** — `org.adempiere.base.process/src/org/compiere/process/TableCreateColumns.java:349` — `|| columnName.toUpperCase().equals("UPDATED") ))`
- **H** — `org.adempiere.base.process/src/org/idempiere/process/CreateTable.java:452` — `&& !table.getTableName().toUpperCase().endsWith("_TRL")`
- **H** — `org.adempiere.base.process/src/org/idempiere/process/CreateTable.java:525` — `if (p_isCreateTranslationTable && !table.getTableName().toUpperCase().endsWith("_TRL"))`
- **H** — `org.adempiere.base.process/src/org/idempiere/process/CreateTable.java:541` — `if (p_isCreateTranslationTable && !table.getTableName().toUpperCase().endsWith("_TRL"))`
- **H** — `org.adempiere.base/src/org/adempiere/process/UUIDGenerator.java:298` — `tableName = tableName.toUpperCase();`
- **H** — `org.adempiere.base/src/org/adempiere/process/UUIDGenerator.java:302` — `tableName = tableName.toLowerCase();`
- **H** — `org.adempiere.base/src/org/adempiere/util/ModelClassGenerator.java:548` — `if (columnName.toLowerCase().startsWith("is"))`
- **H** — `org.adempiere.base/src/org/adempiere/util/ModelClassGenerator.java:657` — `.append("\n\tpublic static final int ").append(columnName.toUpperCase())`
- **H** — `org.adempiere.base/src/org/adempiere/util/ModelClassGenerator.java:737` — `retValue.append("\n\tpublic static final String ").append(columnName.toUpperCase())`
- **H** — `org.adempiere.base/src/org/adempiere/util/ModelInterfaceGenerator.java:361` — `if (columnName.toLowerCase().startsWith("is"))`
- **H** — `org.adempiere.base/src/org/adempiere/util/ModelInterfaceGenerator.java:815` — `StringBuilder tableLike = new StringBuilder().append(tableName.trim().toUpperCase().replace("'", ""));`
- **H** — `org.adempiere.base/src/org/compiere/db/StatementProxy.java:117` — `logSql = getSql().toUpperCase();`
- **H** — `org.adempiere.base/src/org/compiere/dbPort/Convert.java:364` — `if (sqlStatement.toUpperCase().indexOf("EXCEPTION WHEN") != -1) {`
- **H** — `org.adempiere.base/src/org/compiere/dbPort/Convert.java:626` — `String uppStmt = statement.toUpperCase().trim();`
- **H** — `org.adempiere.base/src/org/compiere/dbPort/Convert_SQL92.java:57` — `int fromIndex = Util.findIndexOf (sqlStatement.toUpperCase(), " FROM ");`
- **H** — `org.adempiere.base/src/org/compiere/dbPort/Convert_SQL92.java:58` — `int whereIndex = Util.findIndexOf(sqlStatement.toUpperCase(), " WHERE ");`
- **H** — `org.adempiere.base/src/org/compiere/dbPort/Convert_SQL92.java:59` — `int endWhereIndex = Util.findIndexOf(sqlStatement.toUpperCase(), " GROUP BY ");`
- **H** — `org.adempiere.base/src/org/compiere/dbPort/Convert_SQL92.java:61` — `endWhereIndex = Util.findIndexOf(sqlStatement.toUpperCase(), " ORDER BY ");`
- **H** — `org.adempiere.base/src/org/compiere/dbPort/Convert_SQL92.java:331` — `int index = statement.toUpperCase().indexOf("DECODE", fromIndex);`
- **H** — `org.adempiere.base/src/org/compiere/dbPort/Convert_SQL92.java:417` — `int index = sqlStatement.toUpperCase().indexOf("DELETE ");`
- **H** — `org.adempiere.base/src/org/compiere/model/GridField.java:687` — `&& m_vo.DefaultValue.toUpperCase().equals("NULL")) // IDEMPIERE-2678`
- **H** — `org.adempiere.base/src/org/compiere/model/GridField.java:1075` — `if (value == null || value.toString().length() == 0 || value.toUpperCase().equals("NULL"))`
- **H** — `org.adempiere.base/src/org/compiere/model/MColumn.java:557` — `if (tableName.toLowerCase().endsWith("_trl")) {`
- **H** — `org.adempiere.base/src/org/compiere/model/MColumn.java:823` — `|| (!caseSensitive && columnName.toUpperCase().indexOf("Name".toUpperCase()) != -1) )`
- **H** — `org.adempiere.base/src/org/compiere/model/MColumn.java:1057` — `referenceTableName = referenceTableName.toUpperCase();`
- **H** — `org.adempiere.base/src/org/compiere/model/MColumn.java:1058` — `tableName = tableName.toUpperCase();`
- **H** — `org.adempiere.base/src/org/compiere/model/MColumn.java:1060` — `referenceTableName = referenceTableName.toLowerCase();`
- **H** — `org.adempiere.base/src/org/compiere/model/MColumn.java:1061` — `tableName = tableName.toLowerCase();`
- **H** — `org.adempiere.base/src/org/compiere/model/MColumn.java:1077` — `String key = dbFKName.toLowerCase();`
- **H** — `org.adempiere.base/src/org/compiere/model/MColumn.java:1236` — `tableName = tableName.toUpperCase();`
- **H** — `org.adempiere.base/src/org/compiere/model/MColumn.java:1238` — `tableName = tableName.toLowerCase();`
- **H** — `org.adempiere.base/src/org/compiere/model/MColumn.java:1304` — `if (columnName.toUpperCase().endsWith("_ID"))`
- **H** — `org.adempiere.base/src/org/compiere/model/MColumn.java:1416` — `if (! newColumnName.toLowerCase().equals(getColumnName().toLowerCase())) {`
- **H** — `org.adempiere.base/src/org/compiere/model/MQuery.java:2011` — `int selectIndex = ColumnName.toLowerCase().indexOf("select ");`
- **H** — `org.adempiere.base/src/org/compiere/model/MQuery.java:2012` — `int fromIndex = ColumnName.toLowerCase().indexOf(" from ");`
- **H** — `org.adempiere.base/src/org/compiere/model/MQuery.java:2032` — `if (ColumnName.toUpperCase().startsWith("UPPER(")) {`
- **H** — `org.adempiere.base/src/org/compiere/model/MQuery.java:2111` — `int selectIndex = ColumnName.toLowerCase().indexOf("select ");`
- **H** — `org.adempiere.base/src/org/compiere/model/MQuery.java:2112` — `int fromIndex = ColumnName.toLowerCase().indexOf(" from ");`
- **H** — `org.adempiere.base/src/org/compiere/model/MQuery.java:2126` — `boolean useUpper = (Code instanceof String) && ColumnName.toUpperCase().startsWith("UPPER(");`
- **H** — `org.adempiere.base/src/org/compiere/model/MRole.java:2146` — `if (TableName.toUpperCase().endsWith("_TRL")) continue;`
- **H** — `org.adempiere.base/src/org/compiere/model/MRole.java:2199` — `if (mainSql.toUpperCase().startsWith("SELECT COUNT(*) FROM ")) {`
- **H** — `org.adempiere.base/src/org/compiere/model/MSequence.java:881` — `pstmt.setString(1, tableName.toUpperCase());`
- **H** — `org.adempiere.base/src/org/compiere/model/MTable.java:173` — `pstmt.setString(1, tableName.toUpperCase());`
- **H** — `org.adempiere.base/src/org/compiere/model/MTable.java:396` — `m_columnNameMap.put(column.getColumnName().toUpperCase(), list.size() - 1);`
- **H** — `org.adempiere.base/src/org/compiere/model/MTable.java:441` — `Integer i = m_columnNameMap.get(ColumnName.toUpperCase());`
- **H** — `org.adempiere.base/src/org/compiere/model/MTable.java:556` — `return m_columnNameMap.get(uuColName.toUpperCase()) != null;`
- **H** — `org.adempiere.base/src/org/compiere/model/MViewComponent.java:178` — `if (colSQL == null || colSQL.toUpperCase().equals("NULL"))`
- **H** — `org.adempiere.base/src/org/compiere/model/PO.java:914` — `&& value.toString().toUpperCase().indexOf("=NULL") != -1)`
- **H** — `org.adempiere.base/src/org/compiere/model/POInfo.java:226` — `m_columnNameMap.put(ColumnName.toUpperCase(), list.size() - 1);`
- **H** — `org.adempiere.base/src/org/compiere/model/POInfo.java:317` — `Integer i = m_columnNameMap.get(ColumnName.toUpperCase());`
- **H** — `org.adempiere.base/src/org/compiere/model/Query.java:192` — `if (this.orderBy != null && this.orderBy.toUpperCase().startsWith("ORDER BY"))`
- **H** — `org.adempiere.base/src/org/compiere/model/SetGetUtil.java:204` — `columnNames[i - 1] = rsmd.getColumnName(i).toUpperCase();`
- **H** — `org.adempiere.base/src/org/compiere/print/DataEngine.java:239` — `if (format.isTranslationView() && tableName.toLowerCase().endsWith("_v"))	//	_vt not just _v`
- **H** — `org.adempiere.base/src/org/compiere/print/DataEngine.java:340` — `if (tableName.toLowerCase().endsWith("_vt")){`
- **H** — `org.adempiere.base/src/org/compiere/print/DataEngine.java:362` — `if (tableName.toLowerCase().endsWith("_vt")){`
- **H** — `org.adempiere.base/src/org/compiere/print/MPrintFormat.java:479` — `if (m_translationViewLanguage != null && query != null && query.getTableName().toUpperCase().endsWith("_V"))`
- **H** — `org.adempiere.base/src/org/compiere/process/CreateForeignKey.java:150` — `tableName = tableName.toUpperCase();`
- **H** — `org.adempiere.base/src/org/compiere/process/CreateForeignKey.java:152` — `tableName = tableName.toLowerCase();`
- **H** — `org.adempiere.base/src/org/compiere/process/CreateForeignKey.java:166` — `String key = dbFKName.toLowerCase();`
- **H** — `org.adempiere.base/src/org/compiere/process/CreateForeignKey.java:204` — `int AD_Column_ID = DB.getSQLValue(null, getColumnIDSql, table.getAD_Table_ID(), columnName.toLowerCase());`
- **H** — `org.adempiere.base/src/org/compiere/process/CreateTableIndex.java:125` — `tableName = tableName.toUpperCase();`
- **H** — `org.adempiere.base/src/org/compiere/process/CreateTableIndex.java:127` — `tableName = tableName.toLowerCase();`
- **H** — `org.adempiere.base/src/org/compiere/process/CreateTableIndex.java:140` — `String key = dbIndexName.toLowerCase();`
- **H** — `org.adempiere.base/src/org/compiere/process/CreateTableIndex.java:176` — `tableName = tableName.toUpperCase();`
- **H** — `org.adempiere.base/src/org/compiere/process/CreateTableIndex.java:178` — `tableName = tableName.toLowerCase();`
- **H** — `org.adempiere.base/src/org/compiere/process/CreateTableIndex.java:184` — `String key = primaryKeyName.toLowerCase();`
- **H** — `org.adempiere.base/src/org/compiere/process/CreateTableIndex.java:199` — `String key = tableIndex.getName().toLowerCase();`
- **H** — `org.adempiere.base/src/org/compiere/process/CreateTableIndex.java:228` — `int AD_Column_ID = DB.getSQLValue(null, getColumnIDSql, table.getAD_Table_ID(), dbIndexColumn.toLowerCase());`
- **H** — `org.adempiere.base/src/org/compiere/process/DatabaseElementColumnRename.java:64` — `|| p_NewColumnName.toLowerCase().equals(element.getColumnName().toLowerCase())) {`
- **H** — `org.adempiere.base/src/org/compiere/process/DatabaseTableRename.java:77` — `|| p_NewTableName.toLowerCase().equals(oldTableName.toLowerCase())) {`
- **H** — `org.adempiere.base/src/org/compiere/process/DatabaseTableRename.java:82` — `p_NewTableName.toLowerCase());`
- **H** — `org.adempiere.base/src/org/compiere/process/DatabaseTableRename.java:163` — `String colPrefix = oldTableName.toLowerCase();`
- **H** — `org.adempiere.base/src/org/compiere/process/DatabaseTableRename.java:170` — `if (element.getColumnName().toLowerCase().endsWith("_id")) {`
- **H** — `org.adempiere.base/src/org/compiere/process/DatabaseViewValidate.java:73` — `tableName = tableName.toUpperCase();`
- **H** — `org.adempiere.base/src/org/compiere/process/DatabaseViewValidate.java:75` — `tableName = tableName.toLowerCase();`
- **H** — `org.adempiere.base/src/org/compiere/process/TableIndexValidate.java:70` — `tableName = tableName.toUpperCase();`
- **H** — `org.adempiere.base/src/org/compiere/process/TableIndexValidate.java:72` — `tableName = tableName.toLowerCase();`
- **H** — `org.adempiere.base/src/org/compiere/util/DB.java:2489` — `tblName = tableName.toUpperCase();`
- **H** — `org.adempiere.base/src/org/compiere/util/DB.java:2491` — `tblName = tableName.toLowerCase();`
- **H** — `org.adempiere.base/src/org/compiere/util/DB.java:2900` — `String cleanSql = sql.toLowerCase().replaceAll(removeComments, "").replaceAll(removeQuotedStrings, "").replaceFirst(removeLeadingSpaces, "");`
- **H** — `org.adempiere.base/src/org/idempiere/fa/feature/UseLifeImpl.java:330` — `String columnName = mField.getColumnName().toUpperCase();`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:223` — `p_tablesToExcludeList.add(tableName.toUpperCase());`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:229` — `p_excludeTablesWhere.append(DB.TO_STRING(tableName.toUpperCase()));`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:274` — `p_tablesToPreserveIDsList.add(tableName.toUpperCase());`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:530` — `stmtRC.setString(1, tableName.toUpperCase());`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:537` — `p_columnsVerifiedList.add(tableName.toUpperCase() + "." + columnName.toUpperCase());`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:547` — `p_tablesVerifiedList.add(tableName.toUpperCase());`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:622` — `.append(" WHERE UPPER(AD_Table.TableName)='").append(tableName.toUpperCase())`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:623` — `.append("' AND UPPER(AD_Column.ColumnName)='").append(columnName.toUpperCase()).append("'))")`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:677` — `if (! p_idSystemConversionList.contains(foreignTableName.toUpperCase() + "." + foreignID)) {`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:692` — `p_columnsVerifiedList.add(tableName.toUpperCase() + "." + columnName.toUpperCase());`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:721` — `.append("WHERE  UPPER(t.TableName)=").append(DB.TO_STRING(tableName.toUpperCase()))`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:722` — `.append("       AND UPPER(c.ColumnName)=").append(DB.TO_STRING(columnName.toUpperCase()))`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:804` — `if (! p_tablesVerifiedList.contains(tableName.toUpperCase())) {`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:810` — `keyCol = uuidCol.toUpperCase();`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:812` — `keyCol = tableName.toUpperCase() + "_ID";`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:813` — `if (! p_columnsVerifiedList.contains(tableName.toUpperCase() + "." + keyCol))`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:836` — `if (p_isPreserveAll || p_tablesToPreserveIDsList.contains(tableName.toUpperCase())) {`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:869` — `stmtInsertConv.setString(2, tableName.toUpperCase());`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:883` — `new Object[] {getAD_PInstance_ID(), tableName.toUpperCase(), source_Key.toString(), target_Key.toString(), null},`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:930` — `if (! p_tablesVerifiedList.contains(tableName.toUpperCase())) {`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:944` — `if (! p_columnsVerifiedList.contains(tableName.toUpperCase() + "." + columnName.toUpperCase())) {`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:1064` — `if (att.toUpperCase().endsWith("_ID")) {`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:1151` — `String newUUID = DB.getSQLValueStringEx(get_TrxName(), queryT_MoveClient, getAD_PInstance_ID(), tableName.toUpperCase(), oldUUID);`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:1272` — `if (p_tablesToExcludeList.contains(convertTable.toUpperCase())) {`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:1298` — `getAD_PInstance_ID(), convertTable.toUpperCase(), String.valueOf(key));`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:1314` — `new Object[] {getAD_PInstance_ID(), convertTable.toUpperCase(), key.toString(), convertedId.toString(), null},`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:1538` — `new Object[] {getAD_PInstance_ID(), foreignTableName.toUpperCase(), foreign_Key, local_Key, identifier},`
- **H** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:1540` — `p_idSystemConversionList.add(foreignTableName.toUpperCase() + "." + foreign_Key);`
- **H** — `org.adempiere.base/src/org/idempiere/process/VerifyMigration.java:212` — `listDict.add(columnName.toUpperCase());`
- **H** — `org.adempiere.base/src/org/idempiere/process/VerifyMigration.java:213` — `mapDict.put(columnName.toUpperCase(), vcol);`
- **H** — `org.adempiere.base/src/org/idempiere/process/VerifyMigration.java:232` — `tableName = tableName.toUpperCase();`
- **H** — `org.adempiere.base/src/org/idempiere/process/VerifyMigration.java:234` — `tableName = tableName.toLowerCase();`
- **H** — `org.adempiere.base/src/org/idempiere/process/VerifyMigration.java:238` — `listDB.add(columnName.toUpperCase());`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/AttributeElementHandler.java:74` — `if (!excludes.contains(column.getColumnName().toLowerCase()))`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/AttributeElementHandler.java:76` — `excludes.add(column.getColumnName().toLowerCase());`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/AttributeElementHandler.java:83` — `if (excludes.contains(keycol.toLowerCase()))`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/AttributeUseElementHandler.java:78` — `if (!excludes.contains(column.getColumnName().toLowerCase()))`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/AttributeUseElementHandler.java:80` — `excludes.add(column.getColumnName().toLowerCase());`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/AttributeUseElementHandler.java:87` — `if (excludes.contains(keycol.toLowerCase()))`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/ColumnElementHandler.java:250` — `tableName = tableName.toUpperCase();`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/ColumnElementHandler.java:251` — `columnName = columnName.toUpperCase();`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/ColumnElementHandler.java:253` — `tableName = tableName.toLowerCase();`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/ColumnElementHandler.java:254` — `columnName = columnName.toLowerCase();`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/GenericPOElementHandler.java:145` — `boolean checkExcluded = ! sql.toLowerCase().startsWith("select *");`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/GenericPOElementHandler.java:166` — `if (!excludes.contains(column.getColumnName().toLowerCase())) {`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/GenericPOElementHandler.java:167` — `excludes.add(column.getColumnName().toLowerCase());`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/GenericPOElementHandler.java:172` — `if (excludes.contains(keycol.toLowerCase())) {`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/GenericPOElementHandler.java:176` — `if (excludes.contains(po.getUUIDColumnName().toLowerCase())) {`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/MenuElementHandler.java:139` — `String colName = meta.getColumnName(q).toUpperCase();`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/SQLMandatoryElementHandler.java:59` — `if (sql.endsWith(";") && !(sql.toLowerCase().endsWith("end;")))`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/SQLMandatoryElementHandler.java:96` — `if (sql.toLowerCase().startsWith("delete from ")) {`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/SQLMandatoryElementHandler.java:99` — `String tableName = DB.getSQLValueString(null, "SELECT TableName FROM AD_Table WHERE LOWER(TableName)=?", table.toLowerCase());`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/SQLStatementElementHandler.java:51` — `if (sql.endsWith(";") && !(sql.toLowerCase().endsWith("end;")))`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/SQLStatementElementHandler.java:97` — `if (sql.toLowerCase().startsWith("delete from ")) {`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/SQLStatementElementHandler.java:100` — `String tableName = DB.getSQLValueString(null, "SELECT TableName FROM AD_Table WHERE LOWER(TableName)=?", table.toLowerCase());`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/TableAttributeElementHandler.java:84` — `if (!excludes.contains(column.getColumnName().toLowerCase()))`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/TableAttributeElementHandler.java:86` — `excludes.add(column.getColumnName().toLowerCase());`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/TableAttributeElementHandler.java:93` — `if (excludes.contains(keycol.toLowerCase()))`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/TableAttributeSetElementHandler.java:77` — `if (!excludes.contains(column.getColumnName().toLowerCase()))`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/TableAttributeSetElementHandler.java:79` — `excludes.add(column.getColumnName().toLowerCase());`
- **H** — `org.adempiere.pipo.handlers/src/org/adempiere/pipo2/handler/TableAttributeSetElementHandler.java:86` — `if (excludes.contains(keycol.toLowerCase()))`
- **H** — `org.adempiere.pipo/src/org/adempiere/pipo2/GridTab2PackExporter.java:74` — `if (child.getTableName().toLowerCase().endsWith("_trl")) // ignore trl tabs as they are exported as translation`
- **H** — `org.adempiere.pipo/src/org/adempiere/pipo2/GridTab2PackExporter.java:186` — `if (gridTab.getTableName().toLowerCase().endsWith("_trl"))`
- **H** — `org.adempiere.pipo/src/org/adempiere/pipo2/PackInHandler.java:459` — `if (fkConstraintSql.toLowerCase().contains(" ad_sequence(ad_sequence_id)"))`
- **H** — `org.adempiere.report.jasper/src/org/adempiere/report/jasper/ReportStarter.java:336` — `if (subreports[i].getName().toLowerCase().endsWith(".jasper")`
- **H** — `org.adempiere.report.jasper/src/org/adempiere/report/jasper/ReportStarter.java:337` — `|| subreports[i].getName().toLowerCase().endsWith(".jrxml"))`
- **H** — `org.adempiere.report.jasper/src/org/adempiere/report/jasper/ReportStarter.java:638` — `String originalQueryTemp = originalQueryText.toUpperCase();`
- **H** — `org.adempiere.report.jasper/src/org/adempiere/report/jasper/ReportStarter.java:639` — `int index1 = originalQueryTemp.indexOf(" " + tableName.toUpperCase());`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/form/WSQLProcess.java:229` — `String SQL = sql.toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/form/WSQLQuery.java:209` — `String SQL = sql.toUpperCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/form/WSQLQuery.java:273` — `String colName = header.get(col).toLowerCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/editor/WTableDirEditor.java:308` — `if (tableName.toUpperCase().equals("C_BPARTNER_LOCATION"))`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/info/InfoWindow.java:1192` — `if (! colSQL.toUpperCase().contains(" AS "))`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/info/InfoWindow.java:1295` — `if (! colSQL.toUpperCase().contains(" AS "))`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/info/InfoWindow.java:1423` — `int asIndex = columnName.toUpperCase().lastIndexOf(" AS ");`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/info/InfoWindow.java:1502` — `if (columnClause.toUpperCase().startsWith("UPPER(")) {`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/info/InfoWindow.java:1514` — `if (columnClause.toUpperCase().startsWith("UPPER(")) {`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/info/InfoWindow.java:1528` — `if (columnClause.toUpperCase().startsWith("UPPER(")) {`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/info/InfoWindow.java:2565` — `if(sql.substring(i, i+6).toUpperCase().matches("^(\\s+FROM)(\\s)") && parenthesisLevel == 0)`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/info/InfoWindow.java:2981` — `if (! colSQL.toUpperCase().contains(" AS "))`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/info/RelatedInfoWindow.java:542` — `if (tmp.toLowerCase().endsWith("as"))`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/InfoPanel.java:1544` — `if (tmp.toLowerCase().endsWith("as") && hasAlias)`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/config/ConfigOracle.java:95` — `list.add(def.toLowerCase());`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/config/ConfigOracle.java:96` — `dblist.add(def.toLowerCase());`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/config/ConfigOracle.java:117` — `String entry = entries[e].toLowerCase();`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/config/ConfigOracle.java:269` — `String entry = line.substring(0, line.indexOf('=')).trim().toLowerCase();`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/config/ConfigOracle.java:277` — `&& line.toUpperCase().indexOf("SERVICE_NAME") != -1)`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/config/ConfigOracle.java:279` — `String entry = line.substring(line.indexOf('=')+1).trim().toLowerCase();`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/config/ConfigOracle.java:340` — `data.setProperty(ConfigurationData.ADEMPIERE_DB_PATH, data.getDatabaseType().toLowerCase());`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/partition/TablePartitionService.java:67` — `return DB.getSQLValueEx(trxName, sql, table.getTableName().toUpperCase()) == 1;`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/partition/TablePartitionService.java:182` — `String partKeyColumn = DB.getSQLValueString(trxName, sql, table.getTableName().toUpperCase());`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/partition/TablePartitionService.java:270` — `stmt.setString(1, table.getTableName().toUpperCase());`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/partition/TablePartitionService.java:271` — `stmt.setString(2, primaryPartition.getName().toUpperCase());`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/partition/TablePartitionService.java:352` — `List<List<Object>> columnNames = DB.getSQLArrayObjectsEx(trxName, sql, table.getTableName().toUpperCase());`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/partition/TablePartitionService.java:384` — `String intervalColumn = DB.getSQLValueString(trxName, sql, table.getTableName().toUpperCase());`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/partition/TablePartitionService.java:386` — `if (partitionKeyColumn.getColumnName().toUpperCase().equals(intervalColumn)) {`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/partition/TablePartitionService.java:387` — `if (!interval.toUpperCase().equals(expression)) {`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/partition/TablePartitionService.java:409` — `List<List<Object>> columnNames = DB.getSQLArrayObjectsEx(trxName, sql, table.getTableName().toUpperCase());`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/partition/TablePartitionService.java:450` — `stmt.setString(1, table.getTableName().toUpperCase());`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/partition/TablePartitionService.java:488` — `String autoList = DB.getSQLValueStringEx(trxName, sql, table.getTableName().toUpperCase());`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/partition/TablePartitionService.java:504` — `String interval = DB.getSQLValueStringEx(trxName, sql, table.getTableName().toUpperCase());`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/partition/TablePartitionService.java:520` — `String type = DB.getSQLValueStringEx(trxName, sql, table.getTableName().toUpperCase());`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/partition/TablePartitionService.java:735` — `stmt.setString(1, table.getTableName().toUpperCase());`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/partition/TablePartitionService.java:736` — `stmt.setString(2, table.getTableName().toUpperCase());`
- **H** — `org.compiere.db.oracle.provider/src/org/adempiere/db/oracle/partition/TablePartitionService.java:737` — `stmt.setString(3, table.getTableName().toUpperCase());`
- **H** — `org.compiere.db.oracle.provider/src/org/compiere/db/DB_Oracle.java:300` — `return m_userName.toUpperCase();`
- **H** — `org.compiere.db.oracle.provider/src/org/compiere/db/DB_Oracle.java:841` — `int m_sequence_id = DB.getSQLValueEx(trxName, "SELECT "+name.toUpperCase()+".nextval FROM DUAL");`
- **H** — `org.compiere.db.oracle.provider/src/org/compiere/db/DB_Oracle.java:848` — `final int cnt = DB.getSQLValueEx(trxName, "SELECT COUNT(*) FROM USER_SEQUENCES WHERE UPPER(sequence_name)=?", name.toUpperCase());`
- **H** — `org.compiere.db.oracle.provider/src/org/compiere/db/DB_Oracle.java:856` — `no = DB.executeUpdate("CREATE SEQUENCE "+name.toUpperCase()`
- **H** — `org.compiere.db.oracle.provider/src/org/compiere/db/DB_Oracle.java:867` — `no = DB.executeUpdate("ALTER SEQUENCE "+name.toUpperCase()`
- **H** — `org.compiere.db.oracle.provider/src/org/compiere/db/DB_Oracle.java:872` — `while (DB.getSQLValue(trxName, "SELECT " + name.toUpperCase() + ".NEXTVAL FROM DUAL") < start) {`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/config/ConfigPostgreSQL.java:110` — `data.setProperty(ConfigurationData.ADEMPIERE_DB_PATH, data.getDatabaseType().toLowerCase());`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:150` — `lowerCasePartitionKeyColumnNames.add(partitionKeyColumnName.toLowerCase());`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:188` — `if (constraint_definition.indexOf(getDefaultPartitionName(table).toLowerCase()) >= 0) {`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:189` — `constraint_definition = constraint_definition.replace(getDefaultPartitionName(table).toLowerCase(), table.getTableName().toLowerCase());`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:227` — `stmt.setString(1, getDefaultPartitionName(table).toLowerCase());`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:245` — `String conindid = DB.getSQLValueString(trxName, consql, table.getTableName().toLowerCase(), indexName.toLowerCase());`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:252` — `if (!indexdef.contains(partitionKey.toLowerCase()+",") && !indexdef.contains(partitionKey.toLowerCase()+")")) {`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:253` — `int whereIndex = indexdef.toLowerCase().indexOf(" where ");`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:257` — `indexdef = indexdef.substring(0, indexdef.length()-1)+", "+partitionKey.toLowerCase()+")";`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:260` — `indexdef = indexdef.substring(0, indexdef.length()-1)+", "+partitionKey.toLowerCase()+")";`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:268` — `indexdef = indexdef.replace(" ON adempiere."+getDefaultPartitionName(table).toLowerCase()+" ", " ON adempiere."+table.getTableName().toLowerCase()+" ");`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:276` — `String conindid = DB.getSQLValueString(trxName, consql, table.getTableName().toLowerCase(), indexName.toLowerCase());`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:285` — `indexdef = indexdef.replace(" ON adempiere."+getDefaultPartitionName(table).toLowerCase()+" ", " ON adempiere."+table.getTableName().toLowerCase()+" ");`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:454` — `String defaultPartitionName = getDefaultPartitionName(table).toLowerCase();`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:455` — `String tableName = table.getTableName().toLowerCase();`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:479` — `stmt1.setString(1, viewName.toLowerCase());`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:569` — `currentPartitionKey += " (" + partitionKeyColumn.getColumnName().toLowerCase() + ")";`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:751` — `X_AD_TablePartition partition = createNewRangePartition(rangePartitionInterval, tablePartitionNames, table, partitionKeyColumn, table.getTableName().toLowerCase(),`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:790` — `if (partition.getName().toLowerCase().endsWith("_default_partition"))`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:950` — `List<X_AD_TablePartition> partitions = generateListPartition(table, table.getTableName().toLowerCase(), getDefaultPartitionName(table), partitionKeyColumn, columnValues, null, trxName);`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:991` — `if (partition.getName().toLowerCase().endsWith("_default_partition"))`
- **H** — `org.compiere.db.postgresql.provider/src/org/adempiere/db/postgresql/partition/TablePartitionService.java:1102` — `if (!partitionKey.toLowerCase().startsWith(currentPartitionKey.toLowerCase()))`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/db/DB_PostgreSQL.java:857` — `if (IXName.toUpperCase().endsWith("_KEY"))`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/db/DB_PostgreSQL.java:922` — `m_sequence_id = DB.getSQLValueEx(trxName, "SELECT nextval('"+name.toLowerCase()+"')");`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/db/DB_PostgreSQL.java:938` — `final int cnt = DB.getSQLValueEx(trxName, "SELECT COUNT(*) FROM pg_class WHERE UPPER(relname)=? AND relkind='S'", name.toUpperCase());`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/db/DB_PostgreSQL.java:946` — `no = DB.executeUpdate("CREATE SEQUENCE "+name.toUpperCase()`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/db/DB_PostgreSQL.java:956` — `no = DB.executeUpdate("ALTER SEQUENCE "+name.toUpperCase()`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/db/DB_PostgreSQL.java:1165` — `String lowerCase = columnName.toLowerCase();`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:111` — `String cmpString = statement.toUpperCase();`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:260` — `int found = retValue.toUpperCase().indexOf("DECODE");`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:265` — `found = retValue.toUpperCase().indexOf("DECODE", fromIndex);`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:269` — `int index = retValue.toUpperCase().indexOf("SELECT ");`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:307` — `String datatype = convertMap.get("\\b"+arg2.toUpperCase()+"\\b");`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:476` — `String sqlUpper = sqlStatement.toUpperCase();`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:690` — `(previousToken != null && previousToken.toUpperCase().endsWith("SELECT"))))`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:816` — `String fieldsUpper = fields.toUpperCase();`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:913` — `if ("SELECT".equalsIgnoreCase(t.toString().toUpperCase()))`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1057` — `if (sqlStatement.toUpperCase().indexOf("ALTER TABLE ") == 0) {`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1060` — `if (sqlStatement.toUpperCase().indexOf(" MODIFY ") > 0) {`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1062` — `begin_col = sqlStatement.toUpperCase().indexOf(" MODIFY ")`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1064` — `} else if (sqlStatement.toUpperCase().indexOf(" ADD ") > 0) {`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1065` — `if (sqlStatement.toUpperCase().indexOf(" ADD CONSTRAINT ") < 0 &&`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1066` — `sqlStatement.toUpperCase().indexOf(" ADD FOREIGN KEY " ) < 0 )`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1069` — `begin_col = sqlStatement.toUpperCase().indexOf(" ADD ")`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1104` — `if (rest.toUpperCase().indexOf(" DEFAULT ") != -1) {`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1105` — `String beforeDefault = rest.substring(0, rest.toUpperCase().indexOf(" DEFAULT "));`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1106` — `begin_default = rest.toUpperCase().indexOf(`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1161` — `if (rest.toUpperCase().startsWith("NOT ") || rest.toUpperCase().startsWith("NULL ")`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1162` — `|| rest.toUpperCase().equals("NULL") || rest.toUpperCase().equals("NOT NULL"))`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1173` — `if (rest.toUpperCase().indexOf(" DEFAULT ") != -1) {`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1174` — `begin_default = rest.toUpperCase().indexOf(`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1195` — `if (rest != null && rest.toUpperCase().indexOf("NOT NULL") >= 0)`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1197` — `else if (rest != null && rest.toUpperCase().indexOf("NULL") >= 0)`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1202` — `else if ( rest != null && rest.toUpperCase().indexOf("NOT NULL") >= 0 ) {`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1206` — `else if ( rest != null && rest.toUpperCase().indexOf("NULL") >= 0) {`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1213` — `tableName = tableName.toUpperCase().replace("ALTER TABLE", "");`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1214` — `tableName = tableName.trim().toLowerCase();`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1244` — `if (statement.toUpperCase().matches(".*\\bCLOB\\b.*\\bCONSTRAINT\\b.*CHECK\\b.*\\bIS JSON\\).*")) {`

- **H** — `org.adempiere.base/src/org/compiere/model/MMeasureCalc.java:266` — `index = selectFrom.toUpperCase().indexOf("FROM ");`

### TECH_TOKEN – Technical Token (65)

Protocols, paths, file extensions, class/property names, CSS/OSGi values, and internal keys. Recommendation: use `Locale.ROOT`, `equalsIgnoreCase()`, or an explicitly ASCII-specific strategy.

- **H** — `org.adempiere.base.process/src/org/adempiere/process/PrepareMigrationScripts.java:72` — `return name.toLowerCase().endsWith(".sql");`
- **H** — `org.adempiere.base.process/src/org/compiere/process/RequestEMailProcessor.java:173` — `if(str_Protocol.toLowerCase().equals("imaps"))`
- **H** — `org.adempiere.base.process/src/org/compiere/process/RequestEMailProcessor.java:175` — `else if(str_Protocol.toLowerCase().equals("imap"))`
- **H** — `org.adempiere.base/src/org/adempiere/base/MappedColumnCalloutFactory.java:71` — `key.append(tableName.toLowerCase()).append("|").append(columnName.toLowerCase());`
- **H** — `org.adempiere.base/src/org/adempiere/base/MappedColumnCalloutFactory.java:73` — `key1.append("*|").append(columnName.toLowerCase());`
- **H** — `org.adempiere.base/src/org/adempiere/base/MappedColumnCalloutFactory.java:75` — `key2.append(tableName.toLowerCase()).append("|*");`
- **H** — `org.adempiere.base/src/org/adempiere/base/MappedColumnCalloutFactory.java:96` — `key.append(tableName.toLowerCase()).append("|").append(columnName.toLowerCase());`
- **H** — `org.adempiere.base/src/org/adempiere/base/MappedColumnCalloutFactory.java:110` — `key.append(tableName.toLowerCase()).append("|").append(columnName.toLowerCase());`
- **H** — `org.adempiere.base/src/org/adempiere/base/sso/SSOUtils.java:141` — `String[] urlpath = request.getServletPath().toLowerCase().split("/");`
- **H** — `org.adempiere.base/src/org/compiere/model/GridTab.java:3021` — `if (cmd.toLowerCase().startsWith(MRule.SCRIPT_PREFIX)) {`
- **H** — `org.adempiere.base/src/org/compiere/model/MAttachmentEntry.java:398` — `return m_name.toLowerCase().endsWith(".pdf");`
- **H** — `org.adempiere.base/src/org/compiere/model/MAttachmentEntry.java:407` — `String m_lowname = m_name.toLowerCase();`
- **H** — `org.adempiere.base/src/org/compiere/model/MMeasure.java:657` — `if (cmd.toLowerCase().startsWith(MRule.SCRIPT_PREFIX)) {`
- **H** — `org.adempiere.base/src/org/compiere/model/MProcess.java:482` — `if (pi.getClassName().toLowerCase().startsWith(MRule.SCRIPT_PREFIX)) {`
- **H** — `org.adempiere.base/src/org/compiere/model/MSession.java:528` — `skipChangeLogForUpdateSet.add(tableName.toUpperCase());`
- **H** — `org.adempiere.base/src/org/compiere/model/MSession.java:537` — `skipChangeLogForUpdateSet.remove(tableName.toUpperCase());`
- **H** — `org.adempiere.base/src/org/compiere/model/MSession.java:546` — `return skipChangeLogForUpdateSet.contains(tableName.toUpperCase());`
- **H** — `org.adempiere.base/src/org/compiere/model/MSystem.java:402` — `setDBAddress(dbAddress.toLowerCase());`
- **H** — `org.adempiere.base/src/org/compiere/model/MSystem.java:423` — `setDBInstance(dbName.toLowerCase());`
- **H** — `org.adempiere.base/src/org/compiere/print/MPrintPaper.java:270` — `if (getCode().toLowerCase().startsWith("custom"))`
- **H** — `org.adempiere.base/src/org/compiere/process/ServerProcessCtl.java:337` — `if (m_pi.getClassName().toLowerCase().startsWith(MRule.SCRIPT_PREFIX)) {`
- **H** — `org.adempiere.base/src/org/compiere/process/SvrProcess.java:833` — `map.put(name.toLowerCase(), field);`
- **H** — `org.adempiere.base/src/org/compiere/process/SvrProcess.java:842` — `String name = parameter.getParameterName().trim().toLowerCase();`
- **H** — `org.adempiere.base/src/org/compiere/util/EmailSrv.java:93` — `this.isSSL = this.imapHost.toLowerCase().startsWith ("imap.gmail.com");`
- **H** — `org.adempiere.base/src/org/compiere/util/EmailSrv.java:113` — `this (imapHost, imapUser, imapPass, (imapHost != null && imapHost.toLowerCase().startsWith ("imap.gmail.com"))? 993 : 143, (imapHost != null && imapHost.toLowerCase().startsWith ("imap.gmail.com"))? true : false);`
- **H** — `org.adempiere.base/src/org/compiere/util/Env.java:2285` — `osName = osName.toLowerCase();`
- **H** — `org.adempiere.base/src/org/compiere/util/Env.java:2296` — `osName = osName.toLowerCase();`
- **H** — `org.adempiere.base/src/org/compiere/util/MimeType.java:48` — `if (type[0].equals(extension.toLowerCase()))`
- **H** — `org.adempiere.base/src/org/compiere/util/Msg.java:495` — `className += language.getLanguageCode().toUpperCase();`
- **H** — `org.adempiere.base/src/org/idempiere/process/TranslationImpExp.java:126` — `if (! p_FileName.toLowerCase().endsWith(".zip")) {`
- **H** — `org.adempiere.plugin.utils/src/org/adempiere/plugin/utils/PackInApplicationActivator.java:295` — `if (toProcess.getName().toLowerCase().endsWith(".zip"))`
- **H** — `org.adempiere.plugin.utils/src/org/adempiere/plugin/utils/PackInApplicationActivator.java:304` — `if (file.getName().toUpperCase().endsWith(".ZIP") || file.isDirectory())`
- **H** — `org.adempiere.report.jasper/src/org/adempiere/report/jasper/AttachmentResourceLoader.java:180` — `if (entries[i].getName().toLowerCase().endsWith(".jrxml")`
- **H** — `org.adempiere.report.jasper/src/org/adempiere/report/jasper/AttachmentResourceLoader.java:181` — `|| entries[i].getName().toLowerCase().endsWith(".jasper")) {`
- **H** — `org.adempiere.report.jasper/src/org/adempiere/report/jasper/ColumnLookup.java:130` — `} else if (t.toLowerCase().startsWith("chart/") && (key instanceof Number)) {`
- **H** — `org.adempiere.report.jasper/src/org/adempiere/report/jasper/ColumnLookup.java:145` — `} else if (t.toLowerCase().startsWith("attachment/")) {`
- **H** — `org.adempiere.report.jasper/src/org/adempiere/report/jasper/FileResourceLoader.java:128` — `String lower = name.toLowerCase();`
- **H** — `org.adempiere.server/src/main/server/org/compiere/server/EMailProcessor.java:687` — `else if (p.getContentType().toUpperCase().startsWith("TEXT"))`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/AdempiereIdGenerator.java:104` — `return name.toLowerCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/AdempiereWebUI.java:667` — `ua = ua.toLowerCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/WLogin.java:80` — `ua = ua.toLowerCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/form/WArchiveViewer.java:161` — `if (   media != null && iframe.getSrc() == null && media.getName().toLowerCase().endsWith(".pdf")`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/form/WPluginManager.java:298` — `if (!Util.isEmpty(fFilter.getValue()) && !bundle.getSymbolicName().toUpperCase().contains(fFilter.getValue().toUpperCase()))`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/component/FlexHlayout.java:38` — `setPack(PackType.valueOf(pack.toUpperCase()));`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/component/FlexHlayout.java:52` — `setAlign(AlignType.valueOf(align.toUpperCase()));`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/component/FlexVlayout.java:38` — `setPack(PackType.valueOf(pack.toUpperCase()));`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/component/FlexVlayout.java:52` — `setAlign(AlignType.valueOf(align.toUpperCase()));`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/editor/WEditor.java:748` — `if (style != null && style.toLowerCase().startsWith(MStyle.SCLASS_PREFIX)) {`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/editor/WEditor.java:751` — `} else if (style != null && style.toLowerCase().startsWith(MStyle.ZCLASS_PREFIX)) {`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/factory/ButtonFactory.java:101` — `String className = "btn-" + name.toLowerCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/factory/ZulDashboardGadgetFactory.java:32` — `if (uri != null && uri.toLowerCase().endsWith(".zul")) {`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/LoginPanel.java:897` — `String baselang = s.substring(0, 2).toLowerCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/LoginPanel.java:898` — `StringBuffer lang = new StringBuffer(baselang).append("_").append(s.substring(3).toUpperCase());`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/LoginPanel.java:904` — `if (s.length() == 2 && !arrstr.contains(s.toLowerCase()))`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/panel/LoginPanel.java:905` — `arrstr.add(s.toLowerCase());`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/sso/filter/SSOWebUIFilter.java:115` — `isAdminResRequest = isAdminResRequest || httpRequest.getServletPath().toLowerCase().startsWith("/admin");`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/sso/filter/SSOWebUIFilter.java:118` — `if (httpRequest.getServletPath().toLowerCase().startsWith("/index") || httpRequest.getServletPath().equalsIgnoreCase("/"))`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/sso/filter/SSOWebUIFilter.java:123` — `if (isAdminResRequest && httpRequest.getServletPath().toLowerCase().endsWith("admin"))`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/theme/ThemeManager.java:133` — `if (styleSheet.toLowerCase().startsWith("https://")) {`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/window/WMediaDialog.java:288` — `if (data.toUpperCase().indexOf("<html>") >= 0)`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/window/ZkReportViewer.java:1958` — `if (jasperProcess.getClassname().toLowerCase().startsWith(MRule.SCRIPT_PREFIX)) {`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/idempiere/ui/zk/servlet/AttachmentImageServlet.java:66` — `if (imageData.name() != null && imageData.name().toLowerCase().endsWith(".svg")) {`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/idempiere/ui/zk/websocket/ServerPushEndPoint.java:270` — `String lowerAttr = attr.toLowerCase();`
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/zkforge/keylistener/Keylistener.java:138` — `final String s = keys.substring(j + 1, k).toLowerCase();`
- **H** — `org.adempiere.ui/src/org/compiere/apps/AbstractProcessCtl.java:359` — `if (m_pi.getClassName().toLowerCase().startsWith(MRule.SCRIPT_PREFIX)) {`

### USER_TEXT – User-Facing Text/UI Search (37)

Natural-language labels, search text, and autocomplete comparisons. Recommendation: use an explicit login/user locale or `Collator`; do not apply `Locale.ROOT` indiscriminately.

- **M** — `org.adempiere.install/src/org/compiere/install/util/AppsAction.java:101` — `Character ch = Character.valueOf(toolTipText.toUpperCase().charAt(pos+1));`
- **M** — `org.adempiere.server/src/main/server/org/compiere/server/RequestProcessor.java:626` — `QText = QText.toUpperCase();`
- **M** — `org.adempiere.server/src/main/server/org/compiere/server/RequestProcessor.java:642` — `StringTokenizer st = new StringTokenizer(keyword.toUpperCase(), " ,;\t\n\r\f");`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/DocumentSearchController.java:190` — `String matchString = searchString.toLowerCase();`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/DocumentSearchController.java:193` — `matchString = searchString.substring(searchString.indexOf(" ") + 1).toLowerCase();`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/DocumentSearchController.java:423` — `int match = inputString.toLowerCase().indexOf(matchString);`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/DocumentSearchController.java:439` — `match = inputString.toLowerCase().indexOf(matchString);`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/DocumentSearchController.java:635` — `int match = label.toLowerCase().indexOf(matchString);`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/DocumentSearchController.java:649` — `match = label.toLowerCase().indexOf(matchString);`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/DocumentSearchController.java:738` — `text = text.toLowerCase();`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/DocumentSearchController.java:753` — `} else if (firstStart == null && result.getLabel().toLowerCase().startsWith(text) && text.length() >= 3) {`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/LabelsSearchController.java:197` — `if (rs.getString(2).toUpperCase().equals(value.toUpperCase())) {`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/MenuSearchController.java:590` — `label2 = Util.deleteAccents(label2.toLowerCase());`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/MenuSearchController.java:593` — `compare = Util.deleteAccents(compare.toLowerCase());`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/MenuSearchController.java:662` — `text = text.toLowerCase();`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/MenuSearchController.java:675` — `} else if (firstStart == null && label.toLowerCase().startsWith(text) && text.length() >= 3) {`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/MenuSearchController.java:733` — `if (!Util.isEmpty(highlightText, true) && Util.deleteAccents(data.getLabel()).toLowerCase().contains(Util.deleteAccents(highlightText).toLowerCase())) {`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/MenuSearchController.java:738` — `String matchString = Util.deleteAccents(highlightText.toLowerCase());`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/MenuSearchController.java:739` — `int match = unaccentedLabel.toLowerCase().indexOf(matchString);`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/MenuSearchController.java:755` — `match = unaccentedLabel.toLowerCase().indexOf(matchString);`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/form/WTreeMaintenance.java:325` — `filter = Util.deleteAccents(filter.trim().toUpperCase());`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/apps/form/WTreeMaintenance.java:366` — `String valueItem = item.toString() == null ? "" : Util.deleteAccents(item.toString().toUpperCase());`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/component/AutoComplete.java:175` — `String compare = val.toLowerCase().trim();`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/component/AutoComplete.java:183` — `match = comboItems[i].toLowerCase().startsWith(compare);`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/component/AutoComplete.java:187` — `match = comboItems[i].toLowerCase().contains(compare);`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/component/WAppsAction.java:80` — `Character ch = Character.valueOf(newToolTipText.toLowerCase().charAt(pos + 1));`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/window/FindWindow.java:1725` — `return value.toString().toLowerCase().startsWith(key.toString().toLowerCase());`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/window/RecordTimeLinePanel.java:251` — `.append(Msg.getMsg(Env.getCtx(), "AND").toLowerCase())`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/window/WAutoCompleterCity.java:101` — `search = search.toUpperCase();`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/window/WAutoCompleterCity.java:104` — `if (vo.CityName.toUpperCase().startsWith(search)) {`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/zkoss/addon/chosenbox/Chosenbox.java:664` — `if (prefix == null || s.toLowerCase().startsWith(prefix.toLowerCase()))`
- **M** — `org.adempiere.ui.zk/WEB-INF/src/org/zkoss/addon/chosenbox/Chosenbox.java:670` — `if (prefix == null || s.toLowerCase().startsWith(prefix.toLowerCase()))`
- **M** — `org.idempiere.extension.manager/src/org/idempiere/extension/manager/form/ExtensionBrowserFormController.java:599` — `String filterLower = filter.toLowerCase();`
- **M** — `org.idempiere.extension.manager/src/org/idempiere/extension/manager/form/ExtensionBrowserFormController.java:611` — `if (tag.getAsString().toLowerCase().contains(searchStr)) {`
- **M** — `org.idempiere.extension.manager/src/org/idempiere/extension/manager/form/ExtensionBrowserFormController.java:620` — `if (cat.getAsString().toLowerCase().contains(searchStr)) {`
- **M** — `org.idempiere.extension.manager/src/org/idempiere/extension/manager/form/ExtensionBrowserFormController.java:627` — `if (ext.getName() != null && ext.getName().toLowerCase().contains(searchStr)) {`
- **M** — `org.idempiere.extension.manager/src/org/idempiere/extension/manager/form/ExtensionBrowserFormController.java:629` — `} else if (ext.getDescription() != null && ext.getDescription().toLowerCase().contains(searchStr)) {`

### DOMAIN – Domain-Specific Canonicalization (11)

Business or configuration values with their own normalization contract. Recommendation: decide and document the strategy for each value type; for example, normalize IBAN values explicitly in a locale-neutral way.

- **M** — `org.adempiere.base/src/org/adempiere/process/SalesOrderRateInquiryProcess.java:228` — `unit = unit.toUpperCase();`
- **M** — `org.adempiere.base/src/org/compiere/model/MAuthorizationCredential.java:198` — `if (preferred_username != null && ! email.toLowerCase().equals(preferred_username.toLowerCase()) && EMail.validate(preferred_username)) {`
- **M** — `org.adempiere.base/src/org/compiere/model/MIFixedAsset.java:83` — `key = key.toUpperCase();`
- **M** — `org.adempiere.base/src/org/compiere/model/NaturalAccountMap.java:249` — `IsDocControlled.toUpperCase().startsWith("Y"),`
- **M** — `org.adempiere.base/src/org/compiere/model/NaturalAccountMap.java:250` — `IsSummary.toUpperCase().startsWith("Y"), m_trxName);`
- **M** — `org.adempiere.base/src/org/compiere/model/NaturalAccountMap.java:255` — `put((K)Default_Account.toUpperCase(), (V)na);`
- **M** — `org.adempiere.base/src/org/compiere/util/IBAN.java:31` — `return iban.trim().replace(" ", "").toUpperCase() ;`
- **M** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:333` — `int cntCW = DB.getSQLValueEx(get_TrxName(), "SELECT COUNT(*) FROM W_Store WHERE WebContext=?", p_ClientValue.toLowerCase());`
- **M** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:335` — `throw new AdempiereUserError("WebStore with context " + p_ClientValue.toLowerCase() + " already exists in database");`
- **M** — `org.adempiere.base/src/org/idempiere/process/MoveClient.java:1172` — `parameters[i] = p_ClientValue.toLowerCase();`
- **M** — `org.idempiere.acct/src/org/idempiere/acct/AccountingSetupServiceImpl.java:565` — `int C_ElementValue_ID = setupCtx.m_nap.getC_ElementValue_ID(key.toUpperCase());`

### TEST – Test Code (9)

Locale-dependent transformations in tests. Recommendation: set the locale explicitly in the test or verify the exact production strategy.

- **H** — `org.idempiere.test/src/org/idempiere/test/adwindow/GridTabTest.java:202` — `query.addRestriction("Upper("+MBPartner.COLUMNNAME_Name+")", MQuery.EQUAL, bpartner.getName().toUpperCase());`
- **H** — `org.idempiere.test/src/org/idempiere/test/base/MTableTest.java:438` — `assertTrue(indexName.toUpperCase().contains("AD_USER"), "UUID index name should contain the table name");`
- **H** — `org.idempiere.test/src/org/idempiere/test/base/M_ElementTest.java:171` — `String resolved = M_Element.getColumnName(columnName.toUpperCase());`
- **H** — `org.idempiere.test/src/org/idempiere/test/base/M_ElementTest.java:256` — `duplicate.setColumnName(columnName.toUpperCase());`
- **H** — `org.idempiere.test/src/org/idempiere/test/base/POTest.java:1360` — `MBPartnerInfo[] bpInfos = MBPartnerInfo.find(Env.getCtx(), null, bp.getName().toLowerCase(), "", null, "%", null);`
- **H** — `org.idempiere.test/src/org/idempiere/test/base/QueryTest.java:439` — `assertTrue(sql.toLowerCase().contains("inner join c_bpartner on (ad_user.c_bpartner_id=c_bpartner.c_bpartner_id)"), "Unexpected SQL clause generated from query");`
- **H** — `org.idempiere.test/src/org/idempiere/test/base/ReportTest.java:167` — `assertTrue(entry.getName() != null && entry.getName().toUpperCase().contains(".PDF"), "No PDF report attach to notice");`
- **H** — `org.idempiere.test/src/org/idempiere/test/model/CalloutTest.java:164` — `if (cmd.toLowerCase().startsWith(MRule.SCRIPT_PREFIX))`
- **H** — `org.idempiere.test/src/org/idempiere/test/tracking/AuditTraceContextTest.java:176` — `assertTrue(entry.getName() != null && entry.getName().toUpperCase().contains(".PDF"), "No PDF report attach to notice");`

### VENDORED – Historic/Vendored Code (5)

Migration history or embedded third-party source. Recommendation: do not make an isolated change without a maintenance or upgrade decision.

- **H** — `migration-historic/src/oracle/Column.java:81` — `if (defaultValue.toUpperCase().equals("NULL")) {`
- **H** — `migration-historic/src/oracle/Constraint.java:175` — `if(deleteRule!=null && deleteRule.trim().toUpperCase().equals("NO ACTION")){`
- **H** — `migration-historic/src/oracle/DBDifference.java:1224` — `} else if (searchCondition.toUpperCase().indexOf("IS NOT NULL") != -1) {`
- **H** — `org.apache.ecs/src/org/apache/ecs/GenericElement.java:357` — `return value.toUpperCase();`
- **H** — `org.apache.ecs/src/org/apache/ecs/GenericElement.java:359` — `return value.toLowerCase();`

### INERT – Inactive Comment (3)

The match exists only in commented-out code. Recommendation: no runtime change is required; clean up when appropriate.

- **H** — `org.adempiere.base.process/src/org/compiere/process/TableCreateColumns.java:293` — `// || columnName.toUpperCase().indexOf("DATE") != -1`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1075` — `// sqlStatement.toUpperCase().indexOf(" MODIFY "));`
- **H** — `org.compiere.db.postgresql.provider/src/org/compiere/dbPort/Convert_PostgreSQL.java:1077` — `// sqlStatement.toUpperCase().indexOf(" ADD "));`

## Current upstream/master Addendum

Current comparison baseline:

```text
28acd37703
```

### TECH_TOKEN_ADDED – Added After the Original Classification (3)

These current language-independent technical-token conversions belong to implementation phase `P2`:

- **H** — `org.adempiere.base/src/org/adempiere/base/Core.java:1318` — `String extension = fileExtension != null ? fileExtension.toLowerCase() : "";`
- **H** — `org.adempiere.base/src/org/adempiere/base/Core.java:1382` — `String extension = fileExtension != null ? fileExtension.toLowerCase() : "";`
- **H** — `org.adempiere.report.jasper/src/org/adempiere/report/jasper/JasperReportContentRendererFactory.java:129` — `boolean ok = process.getClassname().toLowerCase().startsWith(MRule.SCRIPT_PREFIX)`

### RESOLVED_UPSTREAM – Removed or Corrected Independently (2)

These original `TECH_TOKEN` locations no longer require an IDEMPIERE-7089 source change:

- **H** — `org.adempiere.base/src/org/compiere/util/MimeType.java:48` *(original baseline)* — The conversion now uses `toLowerCase(Locale.ROOT)` through IDEMPIERE-7077.
- **H** — `org.adempiere.ui.zk/WEB-INF/src/org/adempiere/webui/window/ZkReportViewer.java:1958` *(original baseline)* — The old code path was removed through IDEMPIERE-7070.

The current `master` source contains 460 parameterless case-conversion lines. Of the 52 historical `IDEMPIERE_7082_HANDLED` locations, 51 currently exist on `master`; the additional authorization-code compatibility location is introduced by PR #3332 itself. Excluding those 51 leaves 409 active IDEMPIERE-7089 locations. After rebasing onto PR #3332, the expected result is 411 parameterless source lines, including the two deliberately retained IDEMPIERE-7082 compatibility locations, and the same 409-location IDEMPIERE-7089 scope.

## Prioritization

1. **Exclude IDEMPIERE_7082_HANDLED:** These 52 entries are handled exclusively by PR #3332.
2. **Address DB_VALUE first:** These locations may contain the same defect class, but they do not belong to the existing PR. Review the SQL expression and bound parameter together.
3. **Address TECH_TOKEN next:** Most changes to `Locale.ROOT` or `equalsIgnoreCase()` should be low risk, but they should be implemented in small semantic groups with tests.
4. **Handle USER_TEXT and DOMAIN separately:** Define the locale/collation contract before changing code.
5. **Handle TEST, VENDORED, and INERT last:** Change these only together with the corresponding production change or maintenance decision.

## Known Limitations

- The classification is static and evaluates the visible call context; runtime configurations and external plugin contracts were not exercised.
- Line numbers for the 410 remaining matches refer to the baseline commit above. The 50 removed IDEMPIERE-7082 locations instead use line numbers from the PR base version.
- `Character.toUpperCase(...)`/`Character.toLowerCase(...)` and methods already called with an explicit `Locale` are outside the scope of this inventory.
- DB_VALUE requires validation on PostgreSQL and Oracle. USER_TEXT should be tested with at least Turkish and German locale cases.
