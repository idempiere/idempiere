-- IDEMPIERE-2671 Allocation Target Document Type Implementation
-- Jun 25, 2015 11:07:55 AM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200079,'C_DocType Allocation ','S','C_DocType.DocBaseType IN (''CMA'')  AND C_DocType.AD_Client_ID=@#AD_Client_ID@',0,0,'Y',TO_TIMESTAMP('2015-06-25 11:07:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-06-25 11:07:55','YYYY-MM-DD HH24:MI:SS'),100,'D','c44fbb32-1fdf-481b-b1ab-55fd4a3061d5')
;

-- Jun 25, 2015 11:12:09 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Callout,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212213,0,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',735,200079,'C_DocType_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2015-06-25 11:12:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-06-25 11:12:09','YYYY-MM-DD HH24:MI:SS'),100,'',196,'N','N','D','N','N','N','Y','b8c76f2b-9c80-4f0a-837d-017f4bc5f4af','Y',0,'N','N')
;

-- Jun 25, 2015 11:12:14 AM CEST
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2015-06-25 11:12:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212213
;

-- Jun 25, 2015 11:12:17 AM CEST
UPDATE AD_Column SET FKConstraintName='CDocType_CAllocationHdr', FKConstraintType='N',Updated=TO_TIMESTAMP('2015-06-25 11:12:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212213
;

-- Jun 25, 2015 11:12:17 AM CEST
ALTER TABLE C_AllocationHdr ADD COLUMN C_DocType_ID NUMERIC(10) DEFAULT NULL 
;

-- Jun 25, 2015 11:12:18 AM CEST
ALTER TABLE C_AllocationHdr ADD CONSTRAINT CDocType_CAllocationHdr FOREIGN KEY (C_DocType_ID) REFERENCES c_doctype(c_doctype_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 25, 2015 11:12:54 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (203827,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',661,212213,'Y',22,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-06-25 11:12:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-06-25 11:12:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','125524c2-e746-4bdf-8044-a025d3ffa7b4','Y',170,2)
;

-- Jun 25, 2015 11:14:45 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2015-06-25 11:14:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203827
;

-- Jun 25, 2015 11:14:45 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_TIMESTAMP('2015-06-25 11:14:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10438
;

-- Jun 25, 2015 11:14:45 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, XPosition=2,Updated=TO_TIMESTAMP('2015-06-25 11:14:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10428
;

-- Jun 25, 2015 11:14:45 AM CEST
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2015-06-25 11:14:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10429
;

-- Jun 25, 2015 11:14:45 AM CEST
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2015-06-25 11:14:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10425
;

-- Jun 25, 2015 11:14:45 AM CEST
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2015-06-25 11:14:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10432
;

-- Jun 25, 2015 11:14:45 AM CEST
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2015-06-25 11:14:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10437
;

-- Jun 25, 2015 11:14:45 AM CEST
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2015-06-25 11:14:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10435
;

-- Jun 25, 2015 11:14:45 AM CEST
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2015-06-25 11:14:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10433
;

-- Jun 25, 2015 11:14:45 AM CEST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2015-06-25 11:14:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10440
;

-- Jun 25, 2015 11:14:45 AM CEST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2015-06-25 11:14:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10439
;

-- Jun 25, 2015 11:14:45 AM CEST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2015-06-25 11:14:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10436
;

-- Jun 25, 2015 11:14:46 AM CEST
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2015-06-25 11:14:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10426
;

-- Jun 25, 2015 11:14:46 AM CEST
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2015-06-25 11:14:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10430
;

-- Jun 25, 2015 11:14:46 AM CEST
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2015-06-25 11:14:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10431
;

SELECT register_migration_script('201507011816_IDEMPIERE-2671.sql') FROM dual
;

