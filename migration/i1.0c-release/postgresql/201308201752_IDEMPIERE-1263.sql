-- Aug 20, 2013 5:51:40 PM COT
-- IDEMPIERE-1263 can set "Reservation Locator" of a warehouse by locator of other warehouse
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Description,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,IsActive,AD_Org_ID,AD_Client_ID) VALUES ('M_Locator.M_Warehouse_ID=@0|M_Warehouse_ID@',200053,'D','M_ReserveLocator Tab 0','Where the warehouse field is at tab level 0','S','7086e2fa-88d8-4534-a9f7-3ac151ef840b',100,100,TO_TIMESTAMP('2013-08-20 17:51:38','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-08-20 17:51:38','YYYY-MM-DD HH24:MI:SS'),'Y',0,0)
;

-- Aug 20, 2013 5:52:08 PM COT
-- IDEMPIERE-1263 can set "Reservation Locator" of a warehouse by locator of other warehouse
UPDATE AD_Column SET AD_Val_Rule_ID=200053,Updated=TO_TIMESTAMP('2013-08-20 17:52:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200704
;

-- Aug 26, 2013 11:46:23 AM COT
-- IDEMPIERE-1263 can set Reservation Locator of a warehouse by locator of other warehouse
UPDATE AD_Field SET SeqNo=130, IsDisplayed='Y', XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-08-26 11:46:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200649
;

SELECT register_migration_script('201308201752_IDEMPIERE-1263.sql') FROM dual
;

