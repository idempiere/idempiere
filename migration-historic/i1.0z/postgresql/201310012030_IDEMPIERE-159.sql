-- Oct 1, 2013 8:22:41 PM CEST
-- IDEMPIERE-159 - Allow creation of combinations with Org *
INSERT INTO AD_Val_Rule (AD_Client_ID,AD_Org_ID,AD_Val_Rule_ID,AD_Val_Rule_UU,Code,Created,CreatedBy,EntityType,IsActive,Name,Type,Updated,UpdatedBy) VALUES (0,0,200054,'a1f042c3-77df-4292-b515-89d77c959000','AD_Org.AD_Org_ID = 0 OR (AD_Org.AD_Client_ID=@AD_Client_ID@ AND AD_Org.IsSummary=''N'')',TO_TIMESTAMP('2013-10-01 20:22:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Org of Client not parent (incl 0)','S',TO_TIMESTAMP('2013-10-01 20:22:39','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 1, 2013 8:23:09 PM CEST
-- IDEMPIERE-159 - Allow creation of combinations with Org *
UPDATE AD_Column SET AD_Reference_ID=19, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=200054,Updated=TO_TIMESTAMP('2013-10-01 20:23:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1016
;

SELECT register_migration_script('201310012030_IDEMPIERE-159.sql') FROM dual
;