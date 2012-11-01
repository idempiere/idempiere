-- Mar 19, 2012 8:36:26 PM MYT
-- IDEMPIERE-189 Average Costing: moving average costing doesn't work if AD_Client.IsCostImmediate is false
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=12326
;

-- Mar 19, 2012 8:36:26 PM MYT
-- IDEMPIERE-189 Average Costing: moving average costing doesn't work if AD_Client.IsCostImmediate is false
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=50158
;

-- Mar 19, 2012 8:36:26 PM MYT
-- IDEMPIERE-189 Average Costing: moving average costing doesn't work if AD_Client.IsCostImmediate is false
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=50159
;

-- Mar 19, 2012 8:36:26 PM MYT
-- IDEMPIERE-189 Average Costing: moving average costing doesn't work if AD_Client.IsCostImmediate is false
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=50160
;

-- Mar 19, 2012 8:36:26 PM MYT
-- IDEMPIERE-189 Average Costing: moving average costing doesn't work if AD_Client.IsCostImmediate is false
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=50184
;

-- Mar 19, 2012 8:36:26 PM MYT
-- IDEMPIERE-189 Average Costing: moving average costing doesn't work if AD_Client.IsCostImmediate is false
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=50185
;

-- Mar 19, 2012 8:36:26 PM MYT
-- IDEMPIERE-189 Average Costing: moving average costing doesn't work if AD_Client.IsCostImmediate is false
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=50186
;

-- Mar 19, 2012 8:36:26 PM MYT
-- IDEMPIERE-189 Average Costing: moving average costing doesn't work if AD_Client.IsCostImmediate is false
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=54238
;

-- Mar 19, 2012 8:36:26 PM MYT
-- IDEMPIERE-189 Average Costing: moving average costing doesn't work if AD_Client.IsCostImmediate is false
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=54680
;

-- Mar 19, 2012 8:36:52 PM MYT
-- IDEMPIERE-189 Average Costing: moving average costing doesn't work if AD_Client.IsCostImmediate is false
UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2012-03-19 20:36:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14403
;

UPDATE AD_System
  SET LastMigrationScriptApplied='825_IDEMPIERE-189.sql'
WHERE LastMigrationScriptApplied<'825_IDEMPIERE-189.sql'
   OR LastMigrationScriptApplied IS NULL
;

