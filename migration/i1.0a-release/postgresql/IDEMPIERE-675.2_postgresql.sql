
-- Mar 29, 2013 12:03:32 PM ICT
-- IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Tab SET WhereClause='(SELECT COUNT(*) FROM C_DocType WHERE  C_DocType.C_DocType_ID=M_Inventory.C_DocType_ID AND C_DocType.DocBaseType=''MMI'' AND C_DocType.DocSubTypeInv=''PI'') > 0',Updated=TO_TIMESTAMP('2013-03-29 12:03:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=255
;

-- Mar 29, 2013 12:04:00 PM ICT
-- IDEMPIERE-675 - Internal Use with zero qty is dropping the inventory
UPDATE AD_Tab SET WhereClause='(SELECT COUNT(*) FROM C_DocType WHERE C_DocType.C_DocType_ID=M_Inventory.C_DocType_ID AND C_DocType.DocBaseType=''MMI'' AND C_DocType.DocSubTypeInv=''IU'') > 0',Updated=TO_TIMESTAMP('2013-03-29 12:04:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=682
;

