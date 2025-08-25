-- IDEMPIERE-6124 Add Quantity field to Invoice > Invoice Line > Landed Cost for allocations to Product
SELECT register_migration_script('202508221129_IDEMPIERE-6124.sql') FROM dual;

-- Aug 22, 2025, 11:29:58 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217158,0,'Quantity','Quantity','The Quantity indicates the number of a specific product or item for this document.',759,'Qty',22,'N','N','N','N','N',0,'N',29,0,0,'Y',TO_TIMESTAMP('2025-08-22 11:29:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-08-22 11:29:57','YYYY-MM-DD HH24:MI:SS'),100,526,'Y','N','D','N','N','N','Y','735596b6-61fb-4dfd-babc-bb8fe52261b5','Y',0,'N','N','N','N')
;

-- Aug 22, 2025, 11:30:14 AM MYT
ALTER TABLE C_LandedCost ADD COLUMN Qty NUMERIC DEFAULT NULL 
;

-- Aug 22, 2025, 11:46:59 AM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208844,'Quantity','Quantity','The Quantity indicates the number of a specific product or item for this document.',697,217158,'Y',22,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-08-22 11:46:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-08-22 11:46:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8abf0a74-80e3-41bc-8b20-3abdfc2eab79','Y',110,2)
;

-- Aug 22, 2025, 11:47:32 AM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=4,Updated=TO_TIMESTAMP('2025-08-22 11:47:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208844
;

-- Aug 22, 2025, 11:47:33 AM MYT
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2025-08-22 11:47:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12160
;

-- Aug 22, 2025, 11:47:33 AM MYT
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-08-22 11:47:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204749
;

