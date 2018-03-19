-- Dec 26, 2013 10:24:08 PM ICT
-- IDEMPIERE-1646 Make filter price list (SO/PO) in BP and BP group
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Description,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Org_ID,IsActive,AD_Client_ID) VALUES ('M_PriceList.IsSOPriceList = ''Y''  AND (SELECT COUNT(*) FROM M_PriceList_Version WHERE M_PriceList.M_PriceList_ID=M_PriceList_Version.M_PriceList_ID AND M_PriceList_Version.IsActive=''Y'')>0',200057,'D','M_PriceList is SO','Limits the Sales & Purchase Order window to the correct price lsits','S','83715776-17dc-4e3c-87c2-3d638e43136a',100,100,TO_TIMESTAMP('2013-12-26 22:24:08','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-12-26 22:24:08','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Dec 26, 2013 10:24:45 PM ICT
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Description,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Org_ID,IsActive,AD_Client_ID) VALUES ('M_PriceList.IsSOPriceList = ''N''  AND (SELECT COUNT(*) FROM M_PriceList_Version WHERE M_PriceList.M_PriceList_ID=M_PriceList_Version.M_PriceList_ID AND M_PriceList_Version.IsActive=''Y'')>0',200058,'D','M_PriceList is PO','Limits the Sales & Purchase Order window to the correct price lsits','S','efc89c8e-b74b-4ded-85b1-d266fa967194',100,100,TO_TIMESTAMP('2013-12-26 22:24:45','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-12-26 22:24:45','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Dec 26, 2013 10:25:20 PM ICT
UPDATE AD_Column SET AD_Val_Rule_ID=200057,Updated=TO_TIMESTAMP('2013-12-26 22:25:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2930
;

-- Dec 26, 2013 10:26:04 PM ICT
UPDATE AD_Column SET AD_Val_Rule_ID=200058,Updated=TO_TIMESTAMP('2013-12-26 22:26:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2931
;

-- Dec 27, 2013 10:32:02 AM ICT
UPDATE AD_Column SET AD_Val_Rule_ID=200058,Updated=TO_TIMESTAMP('2013-12-27 10:32:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14637
;

-- Dec 27, 2013 10:32:10 AM ICT
UPDATE AD_Column SET AD_Val_Rule_ID=200057,Updated=TO_TIMESTAMP('2013-12-27 10:32:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14636
;

SELECT register_migration_script('201403122207-IDEMPIERE-1646.sql') FROM dual
;
