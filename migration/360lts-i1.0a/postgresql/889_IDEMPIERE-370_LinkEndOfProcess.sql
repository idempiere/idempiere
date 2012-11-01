-- Aug 22, 2012 8:14:29 PM COT
-- IDEMPIERE-370 Implement link from process ending message to next records
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid) VALUES (0,'N',665,10,'N','N',200320,70,'Y',200309,'N','The Database Table provides the information of the table definition','D','Database Table information','Table','Y','N','5188b164-3159-407e-bb6a-2fa18af5e5df',100,0,TO_TIMESTAMP('2012-08-22 20:14:28','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-22 20:14:28','YYYY-MM-DD HH24:MI:SS'),'Y','Y',70)
;

-- Aug 22, 2012 8:14:29 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200309 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 22, 2012 8:14:49 PM COT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid) VALUES (0,'N',665,10,'Y','N',200321,80,'Y',200310,'N','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.','D','Direct internal record ID','Record ID','Y','N','a2acffa8-7f2f-4b00-b425-51ee0d53a459',100,0,TO_TIMESTAMP('2012-08-22 20:14:49','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-22 20:14:49','YYYY-MM-DD HH24:MI:SS'),'Y','Y',80)
;

-- Aug 22, 2012 8:14:49 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200310 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 22, 2012 8:15:58 PM COT
UPDATE AD_Column SET EntityType='D', AD_Reference_ID=28,Updated=TO_TIMESTAMP('2012-08-22 20:15:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200321
;

-- Aug 22, 2012 8:16:35 PM COT
UPDATE AD_Field SET DisplayLogic='@Record_ID@>0',Updated=TO_TIMESTAMP('2012-08-22 20:16:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200310
;

-- Aug 22, 2012 8:16:39 PM COT
UPDATE AD_Field SET DisplayLogic='@Record_ID@>0',Updated=TO_TIMESTAMP('2012-08-22 20:16:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200309
;

UPDATE AD_System
  SET LastMigrationScriptApplied='889_IDEMPIERE-370_LinkEndOfProcess.sql'
WHERE LastMigrationScriptApplied<'889_IDEMPIERE-370_LinkEndOfProcess.sql'
   OR LastMigrationScriptApplied IS NULL
;
