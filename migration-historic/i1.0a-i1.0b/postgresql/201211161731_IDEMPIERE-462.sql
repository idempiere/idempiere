-- Nov 16, 2012 5:26:48 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('AD_Ref_List.Value NOT IN (''A'', ''F'')',200012,'D','TrxType - No Authorization','S','f7ec6296-14f2-4162-8cf1-ba5912a8d6e4',100,100,TO_TIMESTAMP('2012-11-16 17:26:47','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-11-16 17:26:47','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Nov 16, 2012 5:27:08 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Val_Rule SET Name='TrxType - No Authorizations',Updated=TO_TIMESTAMP('2012-11-16 17:27:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200012
;

-- Nov 16, 2012 5:27:16 PM SGT
-- IDEMPIERE-462 Ticket #1001503: Credit Cards Online
UPDATE AD_Column SET AD_Val_Rule_ID=200012,Updated=TO_TIMESTAMP('2012-11-16 17:27:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5044
;

SELECT register_migration_script('201211161731_IDEMPIERE-462.sql') FROM dual
;