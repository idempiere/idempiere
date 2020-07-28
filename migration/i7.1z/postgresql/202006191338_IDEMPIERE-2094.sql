-- IDEMPIERE-2094  Wrong organization in m_transaction, organization doesnt fit locator
-- Jun 19, 2020, 1:35:26 PM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200140,'M_Locator of Warehouse from Org','S','M_Locator.M_Warehouse_ID IN (SELECT M_Warehouse.M_Warehouse_ID FROM M_Warehouse WHERE M_Warehouse.IsActive=''Y'' AND M_Warehouse.AD_Org_ID=@AD_Org_ID@)',0,0,'Y',TO_TIMESTAMP('2020-06-19 13:35:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-06-19 13:35:26','YYYY-MM-DD HH24:MI:SS'),100,'D','d2f9ddf5-73e4-4984-a932-c41ff65cd2d9')
;

-- Jun 19, 2020, 1:36:34 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=200140,Updated=TO_TIMESTAMP('2020-06-19 13:36:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3591
;

SELECT register_migration_script('202006191338_IDEMPIERE-2094.sql') FROM dual
;

