# Data access patterns (in order of preference)

## 1. Model class

```java
MBPartner bp = MBPartner.get(getCtx(), C_BPartner_ID);          // cached, read-only use
MOrder order = new MOrder(getCtx(), C_Order_ID, get_TrxName());   // when you will modify it
for (MOrderLine line : order.getLines()) {
	...
}
```

### Many records: PO batch API

`BatchInsert`, `BatchUpdate` and `BatchDelete` (`org.compiere.model`) process many POs efficiently. They run the same lifecycle as a single `save()` / `delete()`: before/after hooks, model validators and event handlers, translations, tree nodes and the change log. The only difference is that the POs are not reloaded in memory after the batch runs; re-read a PO if you need values set by the database.

See `org.idempiere.test/src/org/idempiere/test/model/BatchOperationTest.java`.

```java
BatchUpdate<MOrderLine> batch = new BatchUpdate<>(MOrderLine.class);
for (MOrderLine line : lines) {
	line.setDescription("...");
	batch.add(line);
}
batch.executeBatch(get_TrxName());
```

## 2. Query

```java
List<MInvoice> invoices = new Query(getCtx(), MInvoice.Table_Name,
		MInvoice.COLUMNNAME_C_BPartner_ID + "=? AND " + MInvoice.COLUMNNAME_DocStatus + "=?",
		get_TrxName())
	.setParameters(C_BPartner_ID, MInvoice.DOCSTATUS_Completed)
	.setClient_ID()
	.setOnlyActiveRecords(true)
	.setOrderBy(MInvoice.COLUMNNAME_DateInvoiced)
	.list();

int count = new Query(getCtx(), MOrderLine.Table_Name, "C_Order_ID=?", get_TrxName())
	.setParameters(C_Order_ID)
	.count();
```

## 3. DB helpers

```java
int id = DB.getSQLValueEx(get_TrxName(),
		"SELECT M_Product_ID FROM M_Product WHERE AD_Client_ID=? AND Value=?",
		getAD_Client_ID(), value);

String name = DB.getSQLValueStringEx(get_TrxName(),
		"SELECT Name FROM C_BPartner WHERE C_BPartner_ID=?", C_BPartner_ID);

// Bypasses beforeSave, model validators, event handlers and the change log.
// Use only when that is intended; otherwise use BatchUpdate (section 1).
int updated = DB.executeUpdateEx(
		"UPDATE C_OrderLine SET Processed='Y' WHERE C_Order_ID=?",
		new Object[] {C_Order_ID}, get_TrxName());
```

## 4. Raw JDBC (last resort): always close resources

```java
String sql = "SELECT ... FROM ... WHERE AD_Client_ID=? AND ...";
PreparedStatement pstmt = null;
ResultSet rs = null;
try {
	pstmt = DB.prepareStatement(sql, get_TrxName());
	pstmt.setInt(1, getAD_Client_ID());
	rs = pstmt.executeQuery();
	while (rs.next()) {
		...
	}
} catch (SQLException e) {
	throw new DBException(e, sql);
} finally {
	DB.close(rs, pstmt);
	rs = null;
	pstmt = null;
}
```

## Anti-patterns to reject

```java
// String concatenation of values: SQL injection risk and no statement caching
DB.getSQLValue(null, "SELECT ... WHERE Value='" + value + "'");

// null trxName while inside a transaction: reads uncommitted state incorrectly / locks
new MOrder(getCtx(), id, null).saveEx();

// Resources never closed
ResultSet rs = DB.prepareStatement(sql, trx).executeQuery();

// Database-specific syntax
"... LIMIT 1"          // PostgreSQL only; use Query.first() or the helpers
"... ROWNUM = 1"       // Oracle only
```
